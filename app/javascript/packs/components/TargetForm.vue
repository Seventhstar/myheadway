<template>
  <div class="modal" id="myModal">
    <div class="modal-content">
      <div class="modal-head">{{targetName}}
        <span @click="deleteTarget()" class="icon icon_remove right"/>
      </div>

      <div class="modal-body">
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
        <div class="actions">
          <span class="btn btn-success" @click="onSaveTarget()"> Сохранить </span>
          <span class="btn btn_reset" @click="onCancel()">Отменить</span>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  import rorHTTP from "../mixins/rorHTTP";

  export default {
    name: "TargetForm",
    props: ['value'],
    mixins: [rorHTTP],
    data() {
      return {
        id: null,
        token: '',
        target: {},
        sets_names: [],
        parents: [],
        groups: [],
        count_names: [],
        targetTemplate: {
          id: null,
          name: '',
          parent_id: 0,
          user_id: null,
          group_id,
          negative: false,
          sets_name_id: 0,
          count_name_id: 0
        }
      }
    },

    watch: {
      value: function (newVal) {
        console.log('edit form receive value: ' + newVal)
        //console.log('edit form receive value: ' + newVal.toJSON())

        this.fillTargetData(newVal)
      },
    },

    computed: {
      targetName() {
        if (this.target == null) return ''
        return this.target['id'] == null ? 'Новое событие' : 'Редактирование'
      }
    },

    created() {
      this.token = document.querySelector("meta[name=csrf-token]").content
      let element = document.getElementById('targets-data')
      if (element !== null) {
        //this.id = element.dataset.id
        //this.target = JSON.parse(element.dataset.targets)
        this.groups = JSON.parse(element.dataset.groups)
        this.parents = JSON.parse(element.dataset.parents)
        this.sets_names = JSON.parse(element.dataset.setsnames)
        this.count_names = JSON.parse(element.dataset.countnames)
      }
    },

    methods: {
      fillTargetData(newVal) {
        let targetData = newVal === null ? this.targetTemplate : newVal
        for (let i in this.targetTemplate) {
          this.$set(this.target, i, targetData[i])
        }
      },

      onCancel() {
        this.$emit('input')
      },

      onSaveTarget() {
        rorHTTP.sendToServer(this, 'target', {id: this.target.id})
      }
    }
  }
</script>