<template>
  <div class="task_page">
    <div>
      <div class="task_cat_head"></div>
      <ul class="task_cats">
        <li @click="setFilter(0)">{{clearFilterText}}</li>
        <li :class="liClass(l)" @click="setFilter($event, l)" v-for="l in catHeaders">
          {{l}} ({{cats[l].length}})
        </li>
      </ul>
    </div>
    <div>
      <new-task @input="onInput($event)"/>
      <br/>
      <tasks-tabs v-model="currentTab" @switchTab="onSwitchTab($event)"/>
      <task-form v-model="currentTask" @input="onInput($event)" v-show="showModal"/>
      <div class="event-list-container" v-show="currentTab === 0">
        <tasks-items :tasks="grouped[today]" @showModal="onShowModal($event)"/>
      </div>
      <div class="event-list-container" v-show="currentTab === 1">
        <tasks-items :tasks="grouped[tomorrow]" @showModal="onShowModal($event)"/>
      </div>
      <div class="event-list-container" v-show="currentTab === 2">
        <div class="week-days-grid">
          <div class="week-day" v-for="(day, index) in week">
            <div :class="{ 'today': day===today, 'schedule-date': true }">
              {{parseInt(day.substring(8, 10))}}, {{weekDays[index]}}
            </div>
            <tasks-items :tasks="grouped[day]" @showModal="onShowModal($event)" type="week"/>
          </div>
        </div>
      </div>
      <div class="event-list-container" v-show="currentTab === 3">
        <div class="week-days-grid">
          <div class="week-day" v-for="(day, index) in week">
            <div :class="{'today': day===today, 'schedule-date': true }">
              {{weekDays[index]}}
            </div>
          </div>
        </div>
      </div>
      <div class="event-list-container" v-show="currentTab === 4">
        <tasks-items :tasks="filtered" @showModal="onShowModal($event)"/>
      </div>
    </div>
  </div>
</template>

<script>
  import {_} from 'vue-underscore'
  import NewTask from "./NewTask.vue";
  import TaskForm from "./TaskForm.vue";
  import TasksTabs from "./TasksTabs.vue";
  import TasksItems from "./TasksItems.vue";

  export default {
    name: "TaskList",
    data() {
      return {
        id: null,

        today: '',
        tomorrow: '',
        weekDays: ['пн', 'вт', 'ср', 'чт', 'пт', 'сб', 'вс'],
        week: [],
        clearFilterText: '',

        token: '',
        target: null,
        showModal: false,

        tabsValues: [],
        currentTab: 4,

        currentTask: {},

        filtered: [],
        currentFilters: [],

        parents: [],

        tasks: [],

        groups: [],
        grouped: [],

        cats: [],
        catHeaders: [],

        groupNames: []
      }
    },

    created() {
      let element = document.getElementById('task-data')
      if (element !== null) {
        this.tasks = JSON.parse(element.dataset.tasks)
      }

      let date = new Date()
      this.today = this.dateToStr(date)
      date.setDate(date.getDate() + 1)
      this.tomorrow = this.dateToStr(date)
      date = new Date()
      let startOfWeek = new Date(date.setDate(date.getDate() - date.getDay() + (date.getDay() === 0 ? -6 : 1)))

      this.tabsValues.push(this.today)
      this.tabsValues.push(this.tomorrow)
      this.week.length = 0

      this.week.push(this.dateToStr(startOfWeek))
      date = startOfWeek
      for (let i = 0; i < 6; i++) {
        date.setDate(date.getDate() + 1)
        this.week.push(this.dateToStr(date))
      }

      this.tabsValues.push(this.dateToStr(date))
      this.tabsValues.push(this.dateToStr(date))
      this.updateFiltered()
    },

    methods: {

      liClass(l) {
        return this.currentFilters.includes(l) ? "active" : ''
      },

      onInput(e) {
        this.showModal = false
        if (e === undefined) return
        if (e.delete) {
          let forDelete = this.tasks.filter(f => f.id === e.id)
          if (forDelete.length) {
            let index = this.tasks.indexOf(forDelete[0])
            this.tasks.splice(index, 1)
          }
        } else if (!e.update) {
          this.tasks.push(e.data)
        } else {
          let data = e.data
          let forUpdate = this.tasks.filter(e => e.id === data.id)
          if (forUpdate.length > 0) {
            let i = this.tasks.indexOf(forUpdate[0])
            this.$set(this.tasks, i, data)
          }
        }
        this.updateFiltered()
      },

      onAdd() {
        this.showModal = true
        this.currentTask = null
      },

      onShowModal(event) {
        this.showModal = event.showModal
        this.currentTask = event.currentTask
      },

      setFilter(event, filter) {
        if (event === 0) {
          this.currentFilters.length = 0
        } else {
          if (!event.ctrlKey) this.currentFilters.length = 0
          this.currentFilters.push(filter)
        }
        this.updateFiltered()
      },

      updateFiltered() {
        console.log('this.currentFilters', this.currentFilters)
        if (this.currentFilters.length === 0) {
          this.filtered = this.tasks
          this.clearFilterText = ''
        } else {
          this.clearFilterText = 'Сбросить'
          this.filtered = this.tasks.filter(i =>
              this.currentFilters.includes(i.task_cat_name)
          )
        }
        this.updateGroups()
      },

      updateGroups() {
        this.cats = _.groupBy(this.tasks, 'task_cat_name')
        this.catHeaders = Object.keys(this.cats)

        this.grouped = _.groupBy(this.filtered, 'start_date')
        this.groupHeaders = Object.keys(this.grouped)

        for (let i = 0; i < this.groupHeaders.length; ++i) {
          let arr = this.grouped[this.groupHeaders[i]]
          if (arr !== undefined)
            this.$set(this.grouped, this.groupHeaders[i], this.sort(arr))
        }
      },

      sort(arr) {
        return arr.sort((a, b) =>
            (a['time_from'] > b['time_from']) ? 1 : ((b['time_from'] > a['time_from']) ? -1 : 0)
        )
      },

      onSwitchTab(tab) {
        this.currentTab = tab
      },

      dateToStr(date) {
        return date.toISOString().substring(0, 10)
      }
    },

    components: {
      NewTask,
      TaskForm,
      TasksTabs,
      TasksItems
    }
  }
</script>