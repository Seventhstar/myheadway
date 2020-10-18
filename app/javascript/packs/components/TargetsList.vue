<template>
  <div>
    <div class="grid_label_name">
      <label for="name"> Название: </label>
      <input type="text" v-model="target.name" id="name">
      <label> Группа: </label>
      <v-select v-model="target.group_id" :reduce="v=>v.value" :options="groups"></v-select>
      <label> Родитель: </label>
      <v-select v-model="target.parent_id" :reduce="v=>v.value" :options="parents"></v-select>
      <label>Название подхода (повторения):</label>
      <v-select v-model="target.sets_name_id" :reduce="v=>v.value" :options="sets_names"></v-select>
      <label>Название количества:</label>
      <v-select v-model="target.count_name_id" :reduce="v=>v.value" :options="count_names"></v-select>
    </div>
    <br>
    <div class="actns" style="float: right">
      <span class="btn btn_reset ml-2" @click="targetEdit = false">Отменить</span>
      <span class="btn btn-min btn-success" @click="onSaveTarget()"> Сохранить </span>
    </div>
  </div>
</template>

<script>
  import {_} from 'vue-underscore'
  export default {
    name: "TargetsList",
    data() {
      return {
        id: null,
        checked: [],
        targets: []
      }
    },
        // el: '#targets_index',
    // mixins: [m_index],

    created() {

      let element = document.getElementById('targets-data')
      if (element !== null) {
        this.targets = JSON.parse(element.dataset.targets)
        this.checked = element.dataset.cheked
      }


      this.grouped = _.groupBy(this.targets, 'group_name')
      this.groupHeaders = Object.keys(this.grouped)
      document.body.addEventListener('keyup', e => {
        if (event.keyCode === 27) {
          this.targetEdit = false
        } else if (event.keyCode === 13) this.targetEdit = false
      })

      this.targets.forEach((t) => {
        t.checked = Array(this.days).fill(0)
        checks = this.checked.filter(f => f.target_id == t.id)
        checks.forEach((ch) => {
          t.checked[ch.day - 1] = ch.state
        })
      })

      this.month = $("#current_month").val()
      this.year = $("#current_year").val()

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
      mouseOnDay(group) {
        group.cls = "active"
      },

      mouseLeaveDay(group) {
        group.cls = ""
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
          axios.patch(`/targets/${id}`, {format: 'json',
             target: {sets_name_id: this.sets_name_id, group_id: this.group_id}
           }).catch((error) => { console.log(error); });
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
