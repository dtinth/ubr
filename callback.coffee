---
---

query = { }

location.search.replace /(\w+)=([^&]+)/g, (全, 名, 含) ->
  query[名] = decodeURIComponent 含

document.querySelector('#client_id').textContent = query.state
document.querySelector('#code').textContent = query.code
document.querySelector('#uri').textContent = location.protocol + '//' + location.host + location.pathname
