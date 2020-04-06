<template>
  <div class="mb-3 flex items-center">
    <label
      v-if="label"
      class="form-label"
      :for="id"
      style="margin-bottom: 0px;"
    >
    <input
      :id="id"
      ref="input"
      v-bind="$attrs"
      :class="inputClasses"
      type="radio"
      :value="value"
      :name="name"
      @change="$emit('change', $event.target.value)"
    />
    <span class="ml-1">{{ label }}</span>
    </label>
    <div class="inline-flex ml-1">
      <slot />
    </div>
    <div v-if="errors.length" class="form-error">
      {{ errors.join(", ") }}
    </div>
  </div>
</template>

<script>
export default {
  inheritAttrs: false,
  props: {
    id: {
      type: String,
      default() {
        return `text-input-${this._uid}`
      },
    },
    inputClass: {
      type: String,
      default: '',
    },
    value: {
      type: String,
      default: null,
    },
    label: {
      type: String,
      default: null,
    },
    name: {
      type: String,
      default: null,
    },
    errors: {
      type: Array,
      default: () => [],
    },
  },
  computed: {
    inputClasses() {
      let classes = `${this.inputClass}`

      if (this.errors.length > 0) {
        classes += ' error'
      }

      return classes
    },
  },
  methods: {
    focus() {
      this.$refs.input.focus()
    },
    select() {
      this.$refs.input.select()
    },
    setSelectionRange(start, end) {
      this.$refs.input.setSelectionRange(start, end)
    },
  },
}
</script>
