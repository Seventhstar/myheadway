<template>
  <div id="item-add-form" class="inline">
    <span>Новая задача:</span>
    <input type="text" class="txt left" placeholder="Новая задача" id="task_name" v-model="task.name" @keyup.enter="onAdd" ref="name">
    <datetime v-model="task.start_date" class="date" :phrases="phrases" :auto=true></datetime>
    <v-select :options="categories" :reduce="v=>v.value" v-model="task.task_cat_id"></v-select>
    <span id="btn-send" class="btn btn-success" @click="onAdd()">Добавить</span>
  </div>
</template>

<script>
  import axios from "axios";
  import http from "../mixins/rorHTTP";

  export default {
    name: "NewTask",
    mixins: [http],

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

    mounted() {
      setTimeout(() =>this.$refs.name.focus(), 300)
    },

    methods: {
      onAdd() {
        http.sendToServer(this, 'task')
        this.task.name = ''
      },

      // onInput(e) {
      //   console.log('new item e', e)
      // }
    }
  }

</script>

<style scoped>

</style>