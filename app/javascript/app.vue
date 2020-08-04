<template>
  <div id="app">
    <v-app>
      <TopMenu/>
      <v-main>
        <router-view></router-view>
      </v-main>
      
      <v-footer color="#4CAF50" :fixed="true">
        <v-spacer>
          <div>
            Seventhstar {{ new Date().getFullYear() }}
          </div>
        </v-spacer>
      </v-footer>
    </v-app>
  </div>
</template>

<script>
    // import TopMenu from "./packs/components/TopMenu.vue";
    import TopMenu from "./packs/components/TopMenu";
    import hello from "./packs/components/hello.vue";

    export default {
        data: function () {
            return {
                message: "Hello Vue!"
            };
        },
        components: {
            TopMenu: TopMenu,
            hello: hello
        }
    };
</script>

<style scoped>
  p {
    font-size: 2em;
    text-align: center;
  }
</style>