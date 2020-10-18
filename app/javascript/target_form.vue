<template>
  <div id="app">
    <target-form/>
  </div>
</template>

<script>
  import TargetForm from "./packs/components/TargetForm.vue";

  export default {
    data: function () {
      return {
        message: "Hello Vue!",
        groups: [],
      }
    },

    components: {
      'target-form': TargetForm,
    }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
