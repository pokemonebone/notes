# Управление состояниме приложения через Query Parameters

## setParams

`setParams` URL-параметры (query-параметры) текущего адреса в соответствии с массивом объектов `params`, где каждый объект содержит ключ (`keyID`) и значение (`value`). Если значение равно `null` или `undefined`, соответствующий параметр удаляется из URL; в противном случае — добавляется или обновляется. После обновления параметров формируется новая строка поиска (`search`) и новый путь (`newPath`), который предполагалось использовать для навигации (например, через `navigate(newPath, options)` из React Router).

```ts
type ParamEntry = {
  keyID: string
  value: string | null | undefined
}

type Params = {
  params: ParamEntry[]
  location?: WindowLocation | Location
  options?: NavigateOptions<object>
}

export default function setParams({
  params,
  location = window.location,
  options,
}: Params) {
  const urlParams = new URLSearchParams(location.search)

  params.forEach(({ keyID, value }) => {
    if (value == null) {
      urlParams.delete(keyID)
    } else {
      urlParams.set(keyID, String(value))
    }
  })

  const newSearch = urlParams.toString()
  const newPath = `${location.pathname}${newSearch ? `?${newSearch}` : ''}`
  navigate(newPath, options)
}
```
