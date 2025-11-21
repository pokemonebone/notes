# Управление модальными окнами ModalsSet

## ModalsSet

```ts
function ModalsSet() {
  const { search } = useLocation()
  const urlParams = new URLSearchParams(search)
  let modalTypeOpen = urlParams.get(MODAL_PARAM)
  const [firstRun, setFirstRun] = useState(true)

  if (firstRun) {
    // удаление окна при первом запуске
    if (modalTypeOpen === ModalTypes.EDIT) {
      // удаление ключей из params
      setParams({ params: [{ keyID: 'id', value: null }] })
      closeModal()
      modalTypeOpen = null
    }
    setFirstRun(false)
  }

  if (!urlParams.has(MODAL_PARAM)) return null

  return (
    <>
      {modalTypeOpen === ModalTypes.CREATE && <ModalCreate />}
      {modalTypeOpen === ModalTypes.EDIT && <ModalEdit />}
      {modalTypeOpen === ModalTypes.VIEW && <ModalView />}
    </>
  )
}

export default ModalsSet
```

## updateUrlParam

Функция `updateUrlParam` принимает имя параметра, его значение (если нужно установить) и дополнительные опции, обновляет или удаляет соответствующий параметр в URL с помощью `URLSearchParams`, а затем выполняет навигацию без добавления новой записи в историю (`{ replace: true }`). На основе этой универсальной функции реализованы удобные хелперы: `openModal` устанавливает параметр, открывающий модальное окно заданного типа (и, опционально, дополняет URL другими параметрами), а `closeModal` удаляет параметр модального окна из URL, что, вероятно, приводит к его закрытию.

```ts
interface ParamConfig {
  readonly [SPLIT_VIEW_PARAM]: SplitViewTypes
  readonly [MODAL_PARAM]: ModalTypes
}

export default function updateUrlParam<K extends keyof ParamConfig>(
  paramName: K,
  type?: ParamConfig[K],
  options?: Record<string, string>
) {
  const urlParams = new URLSearchParams(location.search)

  if (type) {
    urlParams.set(paramName, type)
    if (options) {
      Object.entries(options).forEach(([key, value]) => {
        urlParams.set(key, value)
      })
    }
  } else {
    urlParams.delete(paramName)
  }

  const newSearch = urlParams.toString()
  const newPath = `${location.pathname}${newSearch ? `?${newSearch}` : ''}`
  navigate(newPath, { replace: true })
}

export const openModal = (type: ModalTypes, options?: Record<string, string>) =>
  updateUrlParam(MODAL_PARAM, type, options)

export const closeModal = () => updateUrlParam(MODAL_PARAM)
```
