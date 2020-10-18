<script>
  import axios from "axios";
  import log from "./../mixins/log.vue"

  export default {
    name: "rorHTTP",
    mixins: [log],

    urlFromModel(model, url) {
      return url == null ? `${model}s` : url
    },

    sendToServer(context, model, id = null, url = null) {
      axios.defaults.headers.common['X-CSRF-TOKEN'] =
          document.querySelector("meta[name=csrf-token]").content

      let path = this.urlFromModel(model, url)
      let data = {format: 'json'}
      data[model] = context[model]
      if (id !== null) {
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

