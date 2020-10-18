<template>
  <div>
    <div class="grid_label_name">
      <label for="name"> Название: </label>
      <input type="text" v-model="target.name" id="name">
      <label> Группа: </label>
      <v-select v-model="target.group_id" :reduce="v=>v.value" :options="groups"></v-select>
      <label> Родитель: </label>
      <v-select v-model="target.parent_id" :reduce="v=>v.value" :options="parents"></v-select>
      <label>Название подхода (повторения):</label>
      <v-select v-model="target.sets_name_id" :reduce="v=>v.value" :options="sets_names"></v-select>
      <label>Название количества:</label>
      <v-select v-model="target.count_name_id" :reduce="v=>v.value" :options="count_names"></v-select>
    </div>
    <br>
    <div class="actns" style="float: right">
      <span class="btn btn_reset ml-2" @click="targetEdit = false">Отменить</span>
      <span class="btn btn-min btn-success" @click="onSaveTarget()"> Сохранить </span>
    </div>
  </div>
</template>

<script>
  import axios from "axios"

  export default {
    name: "TargetForm",
    data() {
      return {
        id: null,
        token: '',
        target: null,
        sets_names: [],
        parents: [],
        groups: [],
        count_names: []
      }
    },

    created() {
      this.token = document.querySelector("meta[name=csrf-token]").content
      let element = document.getElementById('target-data')
      if (element !== null) {
        this.id = JSON.parse(element.dataset.id)
        this.target = JSON.parse(element.dataset.target)
        this.groups = JSON.parse(element.dataset.groups)
        this.parents = JSON.parse(element.dataset.parents)
        this.sets_names = JSON.parse(element.dataset.setsnames)
        this.count_names = JSON.parse(element.dataset.countnames)
      }
    },

    methods: {
      onSaveTarget() {
        const t = this
        if (this.id !== undefined) {
          axios.defaults.headers.common['X-CSRF-TOKEN'] = this.token

          axios.patch(`/targets/${this.id}`, {
            format: 'json',
            target: this.target
          }).then(function (response) {
            console.log('response', response)
          }).catch(function (error) {
            let msg = error.response.status + ' : ' + error.response.statusText
            error.response.data.forEach((e) => {
              msg += '<br/>' + e
            })
            t.$noty.error(msg)
          });
        }

      }
    }
  }
</script>