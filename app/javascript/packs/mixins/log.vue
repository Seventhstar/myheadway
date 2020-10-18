<script>

  export default {
    name: 'log',

    showError: function(context, error) {
      let msg = error.response.status + ' : ' + error.response.statusText
      let err = error.response.data.errors
      if (typeof (err) === 'object')
        for (const [key, value] of Object.entries(err)) {
          msg += '<br/>' + `${key}: ${value}`
        }
      context.$noty.error(msg)
      context.$emit('input', error)
    }
  }
</script>
