<template>
  <div id="item-add-form" class="inline">
    <span>Новая задача:</span>
    <input type="text" class="txt left"
           placeholder="Новая задача"
           id="task_name"
           v-model="task.name"
           @keyup.enter="onAdd" ref="name">
    <datetime v-model="task.start_date" class="date" :phrases="phrases" :auto=true></datetime>
    <v-select :options="categories" :reduce="v=>v.value" v-model="task.task_cat_id"></v-select>
    <span id="btn-send" class="btn btn-success" @click="onAdd()">Добавить</span>
  </div>
</template>

<script>
  import http from "../mixins/rorHTTP";
  import log from '../mixins/log';

  export default {
    name: "NewTask",
    mixins: [http, log],
    props: ['date'],

    data: function () {
      return {
        phrases: {
          Ok: "Выбрать",
          Cancel: "Отменить"
        },
        categories: [],
        task: {
          name: '',
          start_date: new Date().toISOString(),
          task_cat_id: 1
        }
      }
    },

    created() {
      let element = document.getElementById('task-data')
      if (element !== null) {
        this.categories = JSON.parse(element.dataset.categories)
      }
    },

    watch: {
      date: function (newVal, oldVal) {
        console.log('date watch', this.date, newVal)
        this.task.start_date = newVal

      }
    },

    mounted() {
      setTimeout(() => this.$refs.name.focus(), 300)
    },

    methods: {
      onAdd() {
        if (this.task.name.length === 0) {
          //log.showError(this, 'Заполните наименование!')
          this.$noty.error('Заполните наименование!')
        } else {
          http.sendToServer(this, 'task')
          setTimeout(() => {
            this.task.name = ''
          })
        }

      },

      // onInput(e) {
      //   console.log('new item e', e)
      // }
    }
  }

</script>

<style scoped>

</style>