export default function ajaxConfig(ajaxConfig, apiKey) {
  return {
    ...ajaxConfig,
    params: {
      headers: {
        Authorization: `Bearer ${apiKey}`,
      },
    },
  }
}
