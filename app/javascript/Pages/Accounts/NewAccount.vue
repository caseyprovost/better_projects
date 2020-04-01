<template>
  <div class="p-6 bg-indigo-900 min-h-screen flex justify-center items-center">
    <div class="w-full max-w-md">
      <logo
        class="block mx-auto w-full max-w-xs fill-white"
        height="50"
      />
      <form
        class="mt-8 bg-gray-900 rounded-lg shadow-xl overflow-hidden"
        :action="submitRoute"
        method="post"
      >
        <div class="px-10 py-12">
          <h1 class="text-center font-bold text-2xl text-gray-400">
            Let's Get It Started
          </h1>
          <div class="mx-auto mt-6 w-24 border-b-2" />
          <text-input
            v-model="form.name"
            class="mt-10"
            label="Name"
            type="name"
            name="account[name]"
            id="account_name"
            autofocus
            autocapitalize="off"
            :errors="$page.errors.name"
          />
          <text-input
            v-model="form.subdomain"
            class="mt-10"
            label="Subdomain"
            type="text"
            name="account[subdomain]"
            id="account_subdomain"
            autofocus
            autocapitalize="off"
            :errors="$page.errors.subdomain"
          />
        </div>
        <div class="px-10 py-4 bg-gray-900 border-t border-gray-800 flex justify-end items-center w-full">
          <loading-button
            :loading="sending"
            class="btn btn-indigo"
            type="submit"
          >
            Create Account
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
    submitRoute() {
      return this.$routes.accounts()
    }
  },
  methods: {
    submit() {
      this.sending = true
      this.$inertia
        .post(this.$routes.accounts(), {
          account: this.form,
        })
        .then(() => (this.sending = false))
    },
  },
}
</script>
