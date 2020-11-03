<template>
  <div class="tasks-list">
    <div class="task-list-item" v-for="(task, index) in tasks" @dblclick="editTask(task)">
      <div class="check-container">
        <input type="checkbox"
               v-model="task.fixed"
               :id="'task_checked'+[task.id]"
               @click="switchCheck(task)"
               class="custom-checkbox">
        <label :for="'task_checked'+[task.id]"></label>
      </div>
      <span>{{task.name}}</span>
      <span>{{formatDate(task.start_date)}}</span>
      <span>{{task.task_cat_name}}</span>
      <span :class="'icon-cat cat'+[task.task_cat_img_num]"></span>
      <span>{{task.description}}</span>

    </div>
  </div>

</template>

<script>
  import EventForm from "./TaskForm.vue";
  import EventIcon from "./TaskIcon.vue";
  import http from "../mixins/rorHTTP";

  export default {
    name: "TasksItems",
    props: ["tasks", "type"],
    mixins: [http],
    data() {
      return {
        id: null,
        currentTask: 0,
        showModal: false,
        checked: false
        // tasks: [],
      }
    },

    created() {
      // console.log('tasks inside day', this.tasks)
    },

    methods: {
      editTask(event) {
        this.currentTask = event
        this.showModal = true
        this.$emit('showModal', {showModal: true, currentTask: event})
      },

      formatDate(str) {
        return formatDate(str)
      },

      switchCheck(task) {
        setTimeout(() => {
          http.sendToServer(this, 'task', {id: task.id, data: task})
        }, 100)
      },

      formatTime(str) {
        return formatTime(str)
      },
    },

    components:
        {EventForm, EventIcon}
  }
</script>

<style scoped>

</style>