<template>
  <div class="p-6 bg-gray-800 min-h-screen flex justify-center items-center">
    <div class="w-full max-w-md">
      <logo
        class="block mx-auto w-full max-w-xs fill-white"
        height="50"
      />
      <form
        class="mt-8 bg-white rounded-lg shadow-xl overflow-hidden"
        @submit.prevent="submit"
      >
        <div class="px-10 py-12">
          <h1 class="text-center font-bold text-2xl">
            Let's Get It Started
          </h1>
          <div class="mx-auto mt-6 w-24 border-b-2" />
          <text-input
            v-model="form.name"
            class="mt-10"
            label="Name"
            type="name"
            autofocus
            autocapitalize="off"
          />
          <text-input
            v-model="form.subdomain"
            class="mt-10"
            label="Organization subdomain"
            type="text"
            autofocus
            autocapitalize="off"
          />
        </div>
        <div class="px-10 py-4 bg-gray-100 border-t border-gray-200 flex justify-between items-center">
          <loading-button
            :loading="sending"
            class="btn-indigo"
            type="submit"
          >
            Sign Up!
          </loading-button>
        </div>
      </form>
    </div>
  </div>
</template>

<script>
import Layout from '@/Layouts/Minimal'
import LoadingButton from '@/Components/LoadingButton'
import Logo from '@/Components/Logo'
import TextInput from '@/Components/TextInput'
export default {
  metaInfo: { title: 'Sign Up' },
  layout: Layout,
  components: {
    LoadingButton,
    Logo,
    TextInput,
  },
  data() {
    return {
      sending: false,
      form: {
        name: null,
        subdomain: null,
      },
    }
  },
  computed: {
  },
  methods: {
    submit() {
      this.sending = true
      this.$inertia
        .post(this.$routes.account(), {
          user: this.form,
        })
        .then(() => (this.sending = false))
    },
  },
}
</script>
