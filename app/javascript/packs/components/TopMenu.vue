<% include ActionView::Helpers::FormOptionsHelper %>
<% helpers = ActionController::Base.helpers %>
<template>
  <div>
    <v-app-bar app src="<%= helpers.asset_pack_path 'media/images/bg-11.png' %>">

      <v-toolbar-title>
        <router-link to="/" tag="span" style="cursor: pointer">
          {{ appTitle }}
        </router-link>
      </v-toolbar-title>
      <v-spacer></v-spacer>
      <v-icon></v-icon>
      <v-toolbar-items class="hidden-xs-only">
        <v-btn text
          v-for="item in menuItems"
          :key="item.title"
          :href="item.path">
          {{ item.title }}
        </v-btn>
        <v-btn text href="/targets">Цели</v-btn>
        <v-btn text href="/tasks">Задачи</v-btn>
        <v-btn text href="/statements">Высказывания</v-btn>
        <v-btn text href="/books">Книги</v-btn>
        <v-btn text href="/attentions">Интересное</v-btn>
        <v-btn text href="/docs">Док.</v-btn>
      </v-toolbar-items>
      <v-spacer></v-spacer>
      <v-toolbar-items class="hidden-xs-only">
        <v-btn
                text
                v-for="item in rightMenus"
                :key="item.title"
                :href="item.path">
          <v-icon left dark>{{ item.icon }}</v-icon>
          {{ item.title }}
        </v-btn>
      </v-toolbar-items>
    </v-app-bar>

  </div>
</template>

<script>
  export default {
    name: "TopMenu",
    data() {
      return {
        appTitle: 'Awesome App',
        sidebar: false,
        rightMenus: [

          {title: 'Sign Up', path: '/signup', icon: 'face'},
          {title: 'Sign In', path: '/signin', icon: 'lock_open'}
        ],
        menuItems: [
          {title: 'Цели', path: '/targets'},
          {title: 'Задачи', path: '/tasks'},
          {title: 'Высказывания', path: '/statements'},
          {title: 'Книги', path: '/books'},
          {title: 'Home', path: '/landing'},
        ]
      }
    },
  };
</script>
<style>

</style>
