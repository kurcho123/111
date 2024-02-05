import{b as n,d as f,e as k,w as e,m as t,u as c,G as i,s as b,h,t as _,g as T,f as p,c as C,k as x,F as v,n as E}from"./index-243f2949.js";const N={__name:"Input",setup(s){return(u,r)=>{const l=n("font-awesome-icon"),o=n("n-icon"),d=n("n-input");return f(),k(d,{value:c(i).tabs[c(i).currentTab].officers.search,"onUpdate:value":r[0]||(r[0]=g=>c(i).tabs[c(i).currentTab].officers.search=g),placeholder:c(b).locale.PLACEHOLDER.SEARCH,clearable:""},{prefix:e(()=>[t(o,null,{default:e(()=>[t(l,{icon:["fas","magnifying-glass"]})]),_:1})]),_:1},8,["value","placeholder"])}}},A=["src"],B=["src"],F={__name:"Card",props:{fullname:String,alias:String,callsign:String,badgenumber:String,department:Number,rank:Number,status:Boolean,lastSeen:Number,image:String},setup(s){const u=s;function r(){return b.settings.staff.departments.find(o=>o.value===u.department)}function l(){return r().ranks.find(d=>d.value===u.rank)}return(o,d)=>{const g=n("n-divider"),S=n("n-badge"),m=n("n-tag"),a=n("n-space"),w=n("n-tooltip"),L=n("n-card");return f(),k(L,{size:"small",title:s.fullname,hoverable:""},{cover:e(()=>[h("img",{src:s.image?s.image:c(b).settings.staff.no_image,style:{height:"150px","object-fit":"cover"}},null,8,A),t(g,{style:{"margin-top":"0"}})]),"header-extra":e(()=>[t(S,{dot:"",type:s.status?"success":"error"},null,8,["type"])]),footer:e(()=>[t(a,{align:"center",justify:"space-between"},{default:e(()=>{var y;return[h("div",null,_(c(b).locale.LAST_SEEN.replace("{date}",(y=c(T)(s.lastSeen))==null?void 0:y.time)),1),t(w,{trigger:"hover","show-arrow":!1},{trigger:e(()=>[h("img",{src:"../web/images/insignias/"+l().insignia,style:{height:"20px"}},null,8,B)]),default:e(()=>[p(" "+_(l().label),1)]),_:1})]}),_:1})]),default:e(()=>[t(a,{size:"small"},{default:e(()=>[t(m,{bordered:!1},{default:e(()=>[p(_(r().label),1)]),_:1}),t(m,{bordered:!1},{default:e(()=>[p(_(l().label),1)]),_:1}),t(m,{bordered:!1},{default:e(()=>[p(_(s.badgenumber),1)]),_:1}),t(m,{bordered:!1},{default:e(()=>[p(_(s.callsign),1)]),_:1})]),_:1})]),_:1},8,["title"])}}},j={__name:"Grid",setup(s){const u=C(()=>i.tabs[i.currentTab].officers.results.filter(r=>i.tabs[i.currentTab].officers.search.toLowerCase().split(" ").every(l=>Object.values(r).map(o=>String(o).toLowerCase()).some(o=>o.includes(l)))).sort((r,l)=>l.status-r.status));return(r,l)=>{const o=n("n-space"),d=n("n-divider"),g=n("n-gi"),S=n("n-grid"),m=n("n-scrollbar");return f(),x(v,null,[t(o,{justify:"space-between"},{default:e(()=>[h("h3",null,_(c(b).locale.STAFF.STAFF.LABEL),1),t(N)]),_:1}),t(d),t(m,{class:"scrollbar-input_data"},{default:e(()=>[t(S,{"x-gap":10,"y-gap":10,cols:5},{default:e(()=>[(f(!0),x(v,null,E(u.value,a=>(f(),k(g,{key:a.identifier},{default:e(()=>[t(F,{fullname:a.fullname,alias:a.alias,callsign:a.callsign,badgenumber:a.badgenumber,department:a.department,rank:a.rank,status:a.status,lastSeen:a.lastSeen,image:a.image},null,8,["fullname","alias","callsign","badgenumber","department","rank","status","lastSeen","image"])]),_:2},1024))),128))]),_:1})]),_:1})],64)}}},D={class:"box"},R={__name:"index",setup(s){return(u,r)=>(f(),x("div",D,[t(j)]))}};export{R as default};