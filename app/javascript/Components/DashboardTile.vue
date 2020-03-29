<template>
  <a :href="href" class="shadow p-4 w-full bg-gray-900 max-w-sm md:w-1/3 mb-4 hover:cursor-pointer hover:bg-indigo-700">
    <h2 class="text-indigo-400 text-2xl text-center pb-4 border-b border-gray-800">{{ title }}</h2>
    <div class="justify-center flex p-4 flex-wrap">
      <div v-show="empty" class="w-full">
        <div :class="iconWrapperClasses">
          <i :class="iconClasses"></i>
        </div>
      </div>
      <div v-if="empty">
        <p class="text-indigo-100 w-full text-center pt-4 px-6 leading-snug">{{ emptyText }}</p>
      </div>
      <slot name="full" v-if="!empty"></slot>
    </div>
  </a>
</template>

<script>
export default {
  inheritAttrs: false,
  props: {
    title: {
      type: String,
      required: true
    },
    empty: {
      type: Boolean,
      required: true
    },
    iconColor: {
      type: String,
      required: true
    },
    icon: {
      type: String,
      required: true
    },
    emptyText: {
      type: String,
      required: true
    },
    href: {
      type: String,
      required: true
    }
  },
  data() {
    return {
    }
  },
  watch: {
  },
  methods: {
  },
  computed: {
    iconWrapperClasses() {
      return `mx-auto flex-shrink-0 flex items-center justify-center h-24 w-24 rounded-full bg-${this.iconColor}-600 mt-8`
    },
    iconClasses() {
      return `fas fa-${this.icon} text-${this.iconColor}-100 text-5xl`
    }
  }
}
</script>

<style scoped="true">
  a:hover h2 {
    @apply text-indigo-100
  }
</style>
