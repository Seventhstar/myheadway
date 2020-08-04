<template>
  <v-container fluid>
    <v-layout row wrap>
      <h1>Список книг</h1>
      <v-flex xs12 class="text-xs-center" mt-3>
        <p>{{message}}</p>
      </v-flex>

      <v-card>
        <v-card-title> Книги
          <v-spacer></v-spacer>
          <v-text-field
                  v-model="search"
                  append-icon="mdi-magnify"
                  label="Search"
                  single-line
                  hide-details
          ></v-text-field>
        </v-card-title>
        <v-data-table dense hide-default-footer :headers="headers" :items="desserts" :search="search">
          <!--          <v-card-actions>-->
          <!--            <v-spacer></v-spacer>-->
          <!--            <v-btn color="blue darken-1" text @click="close">Cancel</v-btn>-->
          <!--            <v-btn color="blue darken-1" text @click="save">Save</v-btn>-->
          <!--          </v-card-actions>-->
        </v-data-table>
      </v-card>
      <br/>
      <v-spacer></v-spacer>
      <v-simple-table dark>
        <template v-slot:default>
          <thead>
          <tr>
            <th class="text-left">Name</th>
            <th class="text-left">Calories</th>
          </tr>
          </thead>
          <tbody>
          <tr v-for="item in desserts" :key="item.name">
            <td>{{ item.name }}</td>
            <td>{{ item.author_name }}</td>
          </tr>
          </tbody>
        </template>
      </v-simple-table>
      <v-spacer></v-spacer>
    </v-layout>
  </v-container>
</template>

<script>
  import axios from "axios";

  export default {
    data: function () {
      return {
        search: '',
        headers: [
          {
            text: 'Наименование',
            align: 'start',
            value: 'name',
          },
          {text: 'Автор', value: 'author_name'}
        ],
        desserts: [],
        message: "Hello from books!"
      };
    },

    created() {
      this.initialize();
    },

    methods: {
      initialize() {
        return axios
          .get("/books.json")
          .then(response => {
            console.log(response.data);
            this.desserts = response.data;
          })
          .catch(e => {
            console.log(e);
          });
      }
    }
  };
</script>

<style scoped>
  p {
    font-size: 2em;
    text-align: center;
  }
</style>