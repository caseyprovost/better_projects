export default {
  props: {
    resource_errors: Object,
  },
  methods: {
    fieldErrors: function(field) {
      if (this.resource_errors) {
        return this.resource_errors[field]
      } else {
        return []
      }
    },
  },
}
