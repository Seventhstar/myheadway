import Vue from 'vue'
import App from './components/TasksList.vue'
import vSelect from "vue-select"

import underscore from 'vue-underscore'
import VueNoty from 'vuejs-noty'


Vue.use(VueNoty)
Vue.use(underscore)

Vue.component("v-select", vSelect);

import { Datetime } from 'vue-datetime'
import 'vue-datetime/dist/vue-datetime.css'

Vue.use(Datetime)

const axios = require('axios').default;

Vue.component('datetime', Datetime);

function showTasksList() {
  const app = new Vue({
    el: '#tasks-list',
    render: h => h(App)
  }).$mount()
  console.log('tasks-list app', app)
}

//console.log('js')

document.addEventListener('turbolinks:load',function() {
  //console.log('turbolinks:load 2')
});


document.addEventListener('DOMContentLoaded', () => {
  showTasksList();
  //console.log('DOMContentLoaded')
})

document.addEventListener('keyup', (e) => {
  if (e.key === 'Insert')  document.getElementById("task_name").focus()
})
