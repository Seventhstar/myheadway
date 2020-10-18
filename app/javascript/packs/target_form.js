import Vue from 'vue'
//import App from '../target_form.vue'
import App from './components/TargetsList.vue'
import vSelect from "vue-select"
import VueNoty from 'vuejs-noty'


import underscore from 'vue-underscore'

Vue.use(underscore)
Vue.component("v-select", vSelect);
Vue.use(VueNoty)

document.addEventListener('DOMContentLoaded', () => {

  const app = new Vue({
    el: '#targets_index',
    render: h => h(App)
  }).$mount()
  console.log('app', app)

})

document.addEventListener('keyup', (e) => {
  console.log('key code', e)
})
