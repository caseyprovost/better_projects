<template>
  <div class="flex justify-center">
    <div class="w-full">
      <div class="flex rounded-lg  overflow-hidden p-4 w-full flex-wrap">
        <h1 class="text-indigo-400 text-3xl w-full">
          Accounts
        </h1>

        <div
          id="accounts_list"
          class="w-full mt-8 flex flex-wrap sm:flex-row"
        >
          <a
            v-for="account in accounts"
            :href="chooseAccountPath(account)"
            class="md:w-1/4 w-full pr-2 pb-4"
          >
            <account-card :account="account" />
          </a>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import Layout from '@/Layouts/Minimal'
import AccountCard from '@/Components/AccountCard'

export default {
  metaInfo: { title: 'Launch Pad' },
  layout: Layout,
  components: {
    AccountCard,
  },
  props: {
    accounts: Array,
  },
  data() {
    return {
    }
  },
  computed: {
  },
  methods: {
    chooseAccountPath (account) {
      return this.$routes.choose_launch_pad({ account_id: account.id })
    },
  },
}
</script>
