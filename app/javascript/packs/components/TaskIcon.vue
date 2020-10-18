<template>
  <div class="event_icon" v-if="show">
    <template v-if="event.event_type_id == 2">
      <template v-if="event.online">
        <span class="online"></span>
      </template>
      <template v-else>
        <span class="sofa"></span>
      </template>
    </template>
    <div v-else></div>
  </div>
</template>

<script>
  export default {
    name: "EventIcon",
    props: ['show', 'event']
  }
</script>

<style scoped>

</style>