<template>
  <div class="checkbox">
    <label :class="labelClasses"></label>
    <span class="checkbox__button">
    </span>
  </div>
</template>

<script>
  export default {
    props: {
      disabled: {
        type: Boolean,
        default: false
      }
    },
    computed: {
      labelClasses() {
        let classes = "checkbox__label"

        if (this.disabled) {
          classes += " checkbox__label--disabled"
        }

        return classes
      }
    }
  }
</script>

<style scoped="true" language="scss">
  .checkbox__button {
    @apply bg-transparent border border-indigo-700;
    display: inline-block;
    width: 1.4em;
    height: 1.4em;
    border-radius: 0.3em;
  }
</style>
