<template>
  <div class="modal" id="myModal">
    <div class="modal-content">
      <div class="modal-head">{{eventName}}
        <span @click="deleteTask()" class="icon icon_remove right"/>
      </div>


      <div class="modal-body">
        <div class="grid_short_label_name">
          <span>Дата:</span>
          <div class="date-week">
            <datetime v-model="task.start_date" class="date" :phrases="phrases" :auto=true></datetime>
          </div>

          <span>Название:</span>
          <input type="text" v-model="task.name">

          <span>Вид события:</span>
          <v-select :options="categories" :reduce="v=>v.value" v-model="task.task_cat_id"></v-select>

          <span>Комментарий:</span>
          <textarea v-model="task.description">

          </textarea>
          <br></div>
        <div class="actions">
          <span @click="onSaveTarget()" class="btn btn-min btn-success">Сохранить</span>
          <span @click="onCancel()" class="btn btn_reset mr-2">Отменить</span>
        </div>
      </div>
    </div>
  </div>
</template>

<script>

  import axios from "axios";
  import rorHTTP from "../mixins/rorHTTP.vue"

  export default {
    name: "TaskForm",
    props: ['value'],
    mixins: [rorHTTP],
    // props: ['currentEvent'],
    data: function () {
      return {
        phrases: {ok: "Выбрать", cancel: "Отменить"},
        start_date: '',
        time_from: '',
        all_weeks: false,
        duration: 60,
        taskTemplate: {
          id: null,
          name: '',
          start_date: new Date().toISOString(),
          description: '',
          task_cat_id: 1
        },
        task: {},
        categories: '',
        meetings: '',
        users: '',
        type_id: 1,
      }
    },

    watch: {
      value: function (newVal) {
        this.fillTasktData(newVal)
      },
    },

    computed: {
      eventName() {
        return this.task['id'] == null ? 'Новое событие' : 'Редактирование'
      }
    },

    mounted() {
      document.body.addEventListener('keyup', e => {
        if (e.code === "Escape") this.onCancel()
        else if (e.code === "Enter" && e.ctrlKey) this.onSaveTarget()
      })
    },

    created() {
      this.token = document.querySelector("meta[name=csrf-token]").content
      let element = document.getElementById('task-data')
      if (element !== null) {
        this.categories = JSON.parse(element.dataset.categories)
      }
      this.fillTasktData(null)
    },

    methods: {
      fillTasktData(newVal) {
        let taskData = newVal === null ? this.taskTemplate : newVal
        for (let i in taskData) {
          this.$set(this.task, i, taskData[i])
        }
      },

      onCancel() {
        this.$emit('input')
      },

      onSaveTarget() {
        rorHTTP.sendToServer(this, 'task', this.task.id)
      },

      deleteTask() {
        rorHTTP.deleteObject(this, 'task', this.task.id)
      }
    }
  }
</script>

<style scoped>

</style>