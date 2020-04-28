import {SnackbarProgrammatic as Snackbar} from 'buefy'

export default function({
  message,
  type,
  indefinite = false,
  position = 'is-top'
}) {
  Snackbar.open({
    message,
    type,
    indefinite,
    position,
  })
}
