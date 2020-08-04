<template>
  <div class="demo-app">
    <button v-on:click="show = !show">
      Переключить
    </button>
    <transition name="fade">
      <p v-if="show">привет</p>
    </transition>
  </div>
</template>

<script>
export default {
  data() {
    return {
      show: true
    };
  },
  props: ['initial'],
};
</script>