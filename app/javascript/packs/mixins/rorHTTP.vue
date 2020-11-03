<script>
  import axios from "axios";
  import log from "./../mixins/log.vue"

  export default {
    name: "rorHTTP",
    mixins: [log],

    urlFromModel(model, url) {
      return url == null ? `${model}s` : url
    },

    sendToServer(context, model, options = {}) {
      axios.defaults.headers.common['X-CSRF-TOKEN'] =
          document.querySelector("meta[name=csrf-token]").content
      let id = options['id']
      let path = this.urlFromModel(model, options['url'])
      let data = {format: 'json'}
      let source = options['data'] != undefined ? options['data'] :context[model]

      // if ()
      //   data[model] =
      // else
      //   data[model] =
      data[model] = source
      // for (let i in source) {
      //   // this.$set(this.task, i, taskData[i])
      //   console.log('data[model]', model, data[model])
      //   data[model][i] = source[i]
      // }

      console.log('sendToServer data', data)
      if (id !== null && id !== undefined) {
        data['id'] = id
        axios.patch(`/${path}/${id}`, data)
            .then(function (response) {
              context.$emit('input', {update: true, data: response.data})
            }).catch(function (error) {
          log.showError(context, error)
        })
      } else {
        axios.post(`/${path}`, data)
            .then(function (response) {
              context.$emit('input', {update: false, data: response.data})
            }).catch(function (error) {
          log.showError(context, error)
        })
      }
    },


    deleteObject(context, model, id, url = null) {
      let path = this.urlFromModel(model, url)
      axios.defaults.headers.common['X-CSRF-TOKEN'] =
          document.querySelector("meta[name=csrf-token]").content
      if (confirm("Действительно удалить?")) {
        axios.delete(`${path}/${id}`)
            .then(() => {
              context.$emit('input', {delete: true, id: id})
            })
            .catch(function (error) {
              log.showError(context, error)
            })
      }
    }
  }
</script>

