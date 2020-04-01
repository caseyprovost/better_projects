<template>
  <project-form
    :form="form"
    class="bg-gray-900 max-w-3xl"
    @submit="submit"
  >
    <div class="px-2 py-3 bg-gray-800 border-t border-gray-700 flex justify-end items-center">
      <loading-button
        :loading="sending"
        class="btn btn-indigo"
        type="submit"
      >
        Create Project
      </loading-button>
    </div>
  </project-form>
</template>

<script>
import LoadingButton from '@/Components/LoadingButton'
import ProjectForm from './ProjectForm'

export default {
  components: {
    LoadingButton,
    ProjectForm,
  },
  remember: 'form',
  data() {
    return {
      sending: false,
      form: {
        name: null,
        description: null,
      },
    }
  },
  methods: {
    submit() {
      this.sending = true
      this.$inertia.post(this.$routes.projects(), this.form).then(() => {
        this.sending = false
        if (Object.keys(this.$page.errors).length === 0) {
          this.form = {}
          this.$emit('success')
        }
      })
    },
  },
}
</script>
