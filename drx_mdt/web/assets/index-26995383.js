import{c as E,r as $,l as x,z as B,b as o,d as _,e as f,w as r,m as a,D as S,u as n,G as e,p as w,H as D,o as A,E as N,S as V,a as I,f as C,t as T,g as R,s as g,h as L,i as U,I as H,k as y,F as h,n as k,y as O,$ as z}from"./index-243f2949.js";import{_ as M}from"./TopActions-1d666594.js";import{_ as G}from"./EditorContent-c7da8fcb.js";import{_ as P}from"./Box-066ea52c.js";import"./RelatedCard-1683bb11.js";const K={__name:"Input",setup(u){function i(){D({term:e.tabs[e.currentTab].evidence.search,category:e.tabs[e.currentTab].evidence.category})}const c=E(()=>{const s=$([{value:-1,label:x.value.PLACEHOLDER.ALL}]);return s.value.push(...B.value.evidence.categories),s.value});return(s,t)=>{const d=o("font-awesome-icon"),l=o("n-icon"),b=o("n-input"),p=o("n-select"),v=o("n-input-group");return _(),f(v,null,{default:r(()=>[a(b,{onKeyup:t[0]||(t[0]=S(m=>i(),["enter"])),value:n(e).tabs[n(e).currentTab].evidence.search,"onUpdate:value":t[1]||(t[1]=m=>n(e).tabs[n(e).currentTab].evidence.search=m),placeholder:n(x).PLACEHOLDER.SEARCH,clearable:"",disabled:!n(w)(701)},{prefix:r(()=>[a(l,null,{default:r(()=>[a(d,{icon:["fas","magnifying-glass"]})]),_:1})]),_:1},8,["value","placeholder","disabled"]),a(p,{placeholder:n(x).SELECT,options:c.value,value:n(e).tabs[n(e).currentTab].evidence.category,"onUpdate:value":t[2]||(t[2]=m=>n(e).tabs[n(e).currentTab].evidence.category=m),disabled:!n(w)(701)},null,8,["placeholder","options","value","disabled"])]),_:1})}}},j=["innerHTML"],F={__name:"Card",props:{id:Number,title:String,category:Number,content:String,date:Number,author:String},setup(u){const i=u,c=E(()=>s.value?s.value.getHTML():""),s=$(null);return A(()=>{s.value=new N({editable:!1,content:i.content,extensions:[V]})}),I(()=>{s.value.destroy()}),(t,d)=>{const l=o("n-ellipsis"),b=o("n-tag"),p=o("n-space"),v=o("n-card");return _(),f(v,{onClick:d[0]||(d[0]=m=>n(H)(u.id)),title:"#"+u.id+" "+u.title,hoverable:"",size:"small"},{"header-extra":r(()=>{var m;return[C(T((m=n(R)(u.date))==null?void 0:m.time),1)]}),footer:r(()=>[a(p,{align:"center",justify:"space-between"},{default:r(()=>[C(T(n(g).locale.CREATED_BY.replace("{user}",u.author))+" ",1),a(b,{size:"small",bordered:!1},{default:r(()=>[C(T(n(g).locale.EVIDENCE.CATEGORY.replace("{category}",n(g).settings.evidence.categories[u.category].label)),1)]),_:1})]),_:1})]),default:r(()=>[c.value?(_(),f(l,{key:0,"line-clamp":3,tooltip:!1},{default:r(()=>[L("div",{innerHTML:c.value},null,8,j)]),_:1})):U("",!0)]),_:1},8,["title"])}}},Y={__name:"BoxLeft",setup(u){return(i,c)=>{const s=o("n-divider"),t=o("n-space"),d=o("n-scrollbar");return _(),y(h,null,[L("h3",null,T(n(g).locale.EVIDENCE.LABEL),1),a(K),a(s),a(d,{class:"scrollbar-results"},{default:r(()=>[a(t,{vertical:""},{default:r(()=>[(_(!0),y(h,null,k(n(e).tabs[n(e).currentTab].evidence.results,l=>(_(),f(F,{id:l.id,title:l.title,category:l.category,content:l.content,date:l.date,author:l.author},null,8,["id","title","category","content","date","author"]))),256))]),_:1})]),_:1})],64)}}},q={__name:"Top",setup(u){return(i,c)=>(_(),f(M,{target:"evidence",buttons:["create","unlink","save","delete","clear"],required:["title","category","content"],permissions:{create:702,edit:703,delete:704}}))}},X={__name:"Bottom",setup(u){const i=g.locale.PLACEHOLDER,c=E(()=>{const s=e.tabs[e.currentTab].evidence;return s.stats.id?s.stats:s.new});return(s,t)=>{const d=o("n-input"),l=o("n-select"),b=o("n-space");return _(),f(b,{vertical:""},{default:r(()=>[a(d,{placeholder:n(i).TITLE,value:c.value.title,"onUpdate:value":t[0]||(t[0]=p=>c.value.title=p)},null,8,["placeholder","value"]),a(l,{placeholder:n(i).SELECT,options:n(g).settings.evidence.categories,value:c.value.category,"onUpdate:value":t[1]||(t[1]=p=>c.value.category=p)},null,8,["placeholder","options","value"]),a(G,{modelValue:c.value.content,"onUpdate:modelValue":t[2]||(t[2]=p=>c.value.content=p),disabled:!1,class:O("evidence-notes"),placeholder:n(i).NOTES},null,8,["modelValue","placeholder"])]),_:1})}}},J={__name:"BoxMiddle",setup(u){const i=g.locale.EVIDENCE;return(c,s)=>{const t=o("n-space"),d=o("n-divider");return _(),y(h,null,[a(t,{justify:"space-between"},{default:r(()=>[L("h3",null,T(n(e).tabs[n(e).currentTab].evidence.stats.id?n(i).EDIT.replace("{id}","#"+n(e).tabs[n(e).currentTab].evidence.stats.id):n(i).EDIT.replace("{id}","")),1),a(q)]),_:1}),a(d),a(X)],64)}}},Q={__name:"BoxRight",setup(u){const i=["items","officers","citizens","incidents","reports","evidence","tags","gallery"],c=t=>{if(t==="items"&&!e.tabs[e.currentTab].evidence.stats.id)return!1;const d=g.settings.evidence[`show_${t}`],l=d&&e.tabs[e.currentTab].evidence.stats.id?e.tabs[e.currentTab].evidence.stats[t]:e.tabs[e.currentTab].evidence.new[t],b=()=>{t==="items"?z(e.tabs[e.currentTab].evidence.stats.id):["officers","citizens"].includes(t)?(e.tabs[e.currentTab].shared.addUser.type=t,e.tabs[e.currentTab].shared.addUser.view=!0):t==="tags"?(e.tabs[e.currentTab].shared.viewAddTagType="evidence",e.tabs[e.currentTab].shared.viewAddTag=!0):t==="gallery"?(e.tabs[e.currentTab].shared.addToGallery.type="evidence",e.tabs[e.currentTab].shared.addToGalleryView=!0):(e.tabs[e.currentTab].shared.addRelated.type=t,e.tabs[e.currentTab].shared.addRelated.view=!0)};return{identifier:t,title:g.locale.BOXES[t.toUpperCase()],visible:d,array:l,onClick:b}},s=E(()=>i.map(t=>c(t)).filter(t=>t.visible));return(t,d)=>{const l=o("n-gi"),b=o("n-grid"),p=o("n-scrollbar");return _(),f(p,null,{default:r(()=>[a(b,{"y-gap":"10",cols:1},{default:r(()=>[(_(!0),y(h,null,k(s.value,(v,m)=>(_(),f(l,{key:m},{default:r(()=>[a(P,{name:"evidence",identifier:v.identifier,title:v.title,visible:v.visible,array:v.array,onClick:v.onClick},null,8,["identifier","title","visible","array","onClick"])]),_:2},1024))),128))]),_:1})]),_:1})}}},ae={__name:"index",setup(u){return(i,c)=>{const s=o("n-gi"),t=o("n-grid");return _(),y("div",null,[a(t,{"x-gap":"10",cols:"3"},{default:r(()=>[a(s,{class:"box"},{default:r(()=>[a(Y)]),_:1}),a(s,{class:"box"},{default:r(()=>[a(J)]),_:1}),a(s,{class:"box"},{default:r(()=>[a(Q)]),_:1})]),_:1})])}}};export{ae as default};