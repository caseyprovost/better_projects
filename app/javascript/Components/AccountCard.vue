<template>
  <div
    class="bg-indigo-600 p-4 flex flex-col justify-between rounded"
    style="min-height: 10rem;"
  >
    <h3 class="text-xl text-indigo-100">
      {{ account.name }}
    </h3>
  </div>
</template>

<script>

export default {
  components: {
  },
  props: {
    account: Object,
  },
  data() {
    return {
    }
  },
  computed: {
  },
  methods: {
  },
}
</script>
