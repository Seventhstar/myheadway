<template>
  <div>
    <div class="target_edit_modal" v-show="targetEdit">
      <div class="grid_label_name">
        <label for="name"> Название: </label>
        <input type="text" v-model="target.name" id="name">
        <label> Группа: </label>
        <v-select v-model="target.group_id" :reduce="v=>v.value" :options="groups"/>
        <label> Родитель: </label>
        <v-select v-model="target.parent_id" :reduce="v=>v.value" :options="parents"/>
        <label>Название подхода (повторения):</label>
        <v-select v-model="target.sets_name_id" :reduce="v=>v.value" :options="setsnames"/>
        <label>Название количества:</label>
        <v-select v-model="target.count_name_id" :reduce="v=>v.value" :options="countnames"/>
      </div>
      <br>
      <div class="actns" style="float: right">
        <span class="btn btn_reset ml-2" @click="targetEdit = false"> Отменить </span>
        <span class="btn btn-min btn-success" @click="onSaveTarget()"> Сохранить </span>
      </div>
    </div>

    <div id="targets_index">
      <div class="groups">
        <div class="subpills">
          <div class="pill" :class="tabClass(index, group)"
               @click="activeTab = index" @click.ctrl.prevent="edit(group)"
               v-for="(group, index) in groups">{{group.label}}
          </div>
        </div>
        <div class="calendar_period">
          <div class="calendar_period_h">
            <div class="prev_year"></div>
            <div class="prev_month"></div>
            <span class="page active">{{current_period}}</span>
            <div class="next_month"></div>
            <div class="next_year"></div>
          </div>
        </div>
      </div>

      <div id="target_head">
        <div class="table_targets">
          <span class="calenhead head">Цели</span>
          <span :class="dayClass(day)" v-for="day in days">{{day + 1}}</span>
        </div>
      </div>
      <div id="div_target_list">
        <template v-for="(group, index) in groups">
          <template v-for="(target, idx) in grouped[group.label]">
            <div class="table_targets group_day" :target_id="target.id" v-show="index === activeTab">
              <div class="t-item" id="`t-item-${idx}`">
                <div class="target_line_head thead_group"
                     :class="headClass(target)"
                     @click="targetClick(target, $event)"
                     @dblclick="targetClick(target, $event)">
                  <div class="target_name">{{target.name}}</div>
                </div>
              </div>
              <span class="calenday"
                    @mouseover="mouseOnDay(target, d)"
                    @mouseleave="mouseLeaveDay(target)"
                    @click="cellClick(d, target, $event)" :day="d" :state="target.checked[d-1]"
                    v-for="d in days"/>
            </div>
            <div class="table_targets"
                 :target_id="st.id" v-for="(st, i) in subtargets(target)"
                 v-show="index === activeTab">
              <div class="target_line_head" :class="headClass(st)" @click="targetClick(st, $event)"
                   @dblclick="targetClick(st, $event)">
                <div class="subtarget_name">{{st.name}}</div>
              </div>
              <span class="calenday" @mouseover="mouseOnDay(st, d)" @mouseleave="mouseLeaveDay(st)"
                    @click="cellClick(d, st, $event)" :day="d" :state="st.checked[d-1]" v-for="d in days"/>
            </div>

          </template>
        </template>

      </div>
    </div>

  </div>
</template>

<script>
  import {_} from 'vue-underscore'
  import axios from "axios"

  export default {
    name: "TargetsList",
    data() {
      return {
        id: null,
        month: 0,
        year: 0,
        days: [],
        checked: [],
        targets: [],
        groups: [],
        setsnames: [],
        current_period: '',
        targetEdit: false,
        hoverDay: -1,
        activeTab: 0,
        target: {
          name: '',
          parent_id: 0,
          count_name_id: 0
        }
      }
    },
    // el: '#targets_index',
    // mixins: [m_index],

    created() {

      this.parseData('targets-data', 'targets')
      this.parseData('targets-data', 'setsnames')
      this.parseData('targets-data', 'countnames')
      this.parseData('targets-data', 'parents')
      this.parseData('targets-data', 'checked')
      this.parseData('targets-data', 'groups')

      this.getData('targets-data', 'month')
      this.getData('targets-data', 'year')

      // let element = document.getElementById('targets-data')
      // if (element !== null) {
      //   this.targets = JSON.parse(element.dataset.targets)
      //   this.checked = JSON.parse(element.dataset.cheked)
      // }

      this.grouped = _.groupBy(this.targets, 'group_name')
      this.groupHeaders = Object.keys(this.grouped)

      console.log('this.checked', this.checked, this.month)

      document.body.addEventListener('keyup', e => {
        if (e.key === 'Escape') {
          this.targetEdit = false
        } else if (e.key === 'Enter') {
          this.targetEdit = false
        }
      })

      this.targets.forEach((t) => {
        t.checked = Array(this.days).fill(0)
        let checks = this.checked.filter(f => f.target_id == t.id)
        checks.forEach((ch) => {
          t.checked[ch.day - 1] = ch.state
        })
      })

      let d = new Date()
      d = new Date(d.getFullYear(), d.getMonth() + 1, 0);
      this.days = Array.from(Array(d.getDate()).keys())

      this.current_period = new Date().toLocaleDateString('ru-RU', {month: 'long', year: 'numeric'}).toUpperCase()

      // this.month = $("#current_month").val()
      // this.year = $("#current_year").val()

      let token = document.head.querySelector('meta[name="csrf-token"]').content
      axios.defaults.headers.common['X-CSRF-TOKEN'] = token
    },

    computed: {
      targetName() {
        if (typeof (this.currentTarget) == "object") return this.currentTarget.name
        return ""
      }
    },

    methods: {
      dayClass(day) {
        let cls = "calenhead"
        let today = new Date()

        let d = new Date(today.getFullYear(), today.getMonth(), day)
        // d.g

        // console.log('today', today, 'day', day, 'd', d)
        if(d.getDay() >= 5)
          cls = cls + ' holiday'

        if ( day === today.getDay())
          cls = cls + ' today'

        if (day === this.hoverDay)
          cls = cls + ' active'


          return cls
      },

      getData(elementName, itemName) {
        let element = document.getElementById(elementName)
        if (element !== null) {
          let data = element.dataset[itemName]
          if (data != undefined) {
            this[itemName] = data
          }
        }
      },

      parseData(elementName, itemName) {
        let element = document.getElementById(elementName)
        if (element !== null) {
          let data = element.dataset[itemName]
          if (data != undefined)
            this[itemName] = JSON.parse(data)
        }
      },

      mouseOnDay(group, day) {
        group.cls = "active"
        this.hoverDay = day
      },

      mouseLeaveDay(group) {
        group.cls = ""
        this.hoverDay = -1
      },

      cellClick(day, target, event) {
        this.currentTarget = target
        let ch = target.checked[day - 1]
        if (event.ctrlKey) {
          this.targetEdit = true
          return
        }

        let state = target.checked[day - 1];
        let spkey = false;
        if (event.shiftKey) {
          state = 3;
          spkey = true;
        }
        // if (event.ctrlKey) {state = 0; spkey = true;}
        if (event.altKey) {
          state = 1;
          spkey = true;
        }
        if (!state) {
          state = 2;
        } else if (!spkey) {
          state = state + 1;
          if (state > 2) state = 0;
        }

        target.checked[day - 1] = state

        axios.post('/ajax/target_days', {
          day: day,
          target: target.id,
          format: 'json',
          state: state,
          month: this.month,
          year: this.year
        }).then(response => {
          console.log('response', response)
        })
      },

      targetClick(target, event) {
        this.currentTarget = target
        this.currentIndex = this.targets.indexOf(target)
        if (event.ctrlKey || event.type === "dblclick") {
          this.sets_name_id = target.sets_name_id
          this.group_id = target.group_id
          this.targetEdit = true
        }
      },

      onSaveTargetDay() {
        this.targetEdit = false
      },

      onSaveTarget() {
        this.targetEdit = false
        let id = this.targets[this.currentIndex].id
        this.targets[this.currentIndex].sets_name_id = this.sets_name_id
        this.targets[this.currentIndex].group_id = this.group_id

        if (this.sets_name_id !== undefined) {
          axios.patch(`/targets/${id}`, {
            format: 'json',
            target: {sets_name_id: this.sets_name_id, group_id: this.group_id}
          }).catch((error) => {
            console.log(error);
          });
        }
      },

      headClass(group) {
        return group.cls
      },

      tabClass(index, group) {
        let cls = ""
        if (this.activeTab === index) cls += "active "
        if (this.groups[index].negative === 'true' || this.groups[index].negative) cls += "negative "

        return cls
      },

      subtargets(target) {
        if (target == undefined || target.id == undefined) return []
        return this.targets.filter(f => f.parent_id == target.id)
      },

      edit(group) {
        window.open('/tgroups/' + group.id + '/edit', '_blank');
      },

    }
  }
</script>
