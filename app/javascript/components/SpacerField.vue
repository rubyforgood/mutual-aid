<!--
  This is a workaround for a specific combination of Bulma + Vue constraints.

  Bulma adds a bottom margin to all but the last field in a set, eg:
  ```
  .field:not(:last-child) {
    margin-bottom: 0.75rem;
  }
  ```

  This works great when all fields are sibling elements.
  But we often need to extract a set of fields into a sub-component, eg:
  ```
  <form>
    <b-field>...</b-field>
    <SubComponent contains="multiple fields"/>
    <b-field>...</b-field>
  </form>
  ```

  If the sub-component above contains multiple fields, Vue will force them
  to be wrapped in a single 'root' element. This would then render as:
  ```
  <form>
    <b-field>...</b-field>
    <div is="the root element from SubComponent">
      <b-field>...</b-field>
      <b-field is="now the 'last' field amongst its siblings, so has no bottom margin" />
    </div>
    <b-field is="now pressed up against the field above">...</b-field>
  </form>

  The workaround is to insert an empty field between the sub-component and the next field.
  ```
    <b-field>...</b-field>
    <SubComponent />
    <SpacerField is="now the last field so has bottom margin" />
    <b-field>...</b-field>
  ```

  This is preferable to manually applying a margin because staying within Bulma's system
  allows it to be more reliably responsive.
-->
<template>
  <b-field />
</template>
