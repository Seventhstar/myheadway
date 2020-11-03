<template>
  <div id="task-tabs">
    <span :class="tabClass(index)" @click="onClick(index)" v-for="tab, index in tabs">
      {{tab}}
    </span>
  </div>
</template>

<script>
  export default {
    name: "TasksTabs",
    data() {
      return {
        currentTab: 4,
        tabs: ["Сегодня", "Завтра", "Неделя", "Месяц", "Без даты", "Все"],
        tabsValues: []
      }
    },

    created() {
      this.tabsValues.length = 0
    },

    methods: {
      tabClass(index) {
        if (this.currentTab === index) return "active tab"
        return "tab"
      },

      onClick(index) {
        this.currentTab = index
        this.$emit('switchTab', index)
      }
    }
  }
</script>

<style scoped>


</style>