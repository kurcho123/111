import{al as w,c as k,s as p,Z as C,am as g,G as e,p as v,r as O,R as I,an as L,b as d,d as a,k as i,u as o,e as A,_ as R,m as u,w as h,O as S,ao as E}from"./index-243f2949.js";const N={class:"config-nav"},B={key:1},F={__name:"Header",setup(T){const y=w(),l={13371:2,13372:4,13373:5},_=k(()=>({13371:p.locale.CONFIGURATIONS.STAFF.LABEL,13372:p.locale.CONFIGURATIONS.ROLES.LABEL,13373:p.locale.CONFIGURATIONS.CHARGES.LABEL}));C(()=>{const s=g.find(t=>t.key===1337);(!s||!s.children)&&(e.tabs[e.currentTab].config.anyAccess=!1),s.children.map(t=>{if(!t.meta.show)return;v(l[t.key])&&(e.tabs[e.currentTab].config.anyAccess=!0)})});const f=k(()=>{const s=O([]);let t=null,c=null;const r=g.find(n=>n.key===1337);if(!r||!r.children)return s.value;const m=e.tabs[e.currentTab].config.key;if(m){const n=r.children.find(b=>b.key===m);n&&(t=`/configurations/${n.path}`,c=n.key)}return r.children.map(n=>{if(n.meta.label=_.value[n.key],!n.meta.show)return;if(v(l[n.key])){const x={label:()=>I(L,{to:`/configurations/${n.path}`},{default:()=>n.meta.label}),key:n.key};s.value.push(x),t||(t=`/configurations/${n.path}`,c=n.key)}}),t&&!e.tabs[e.currentTab].config.key&&(y.push(t),e.tabs[e.currentTab].config.key=c),s.value});return(s,t)=>{const c=d("n-menu");return a(),i("div",N,[o(e).tabs[o(e).currentTab].config.anyAccess?(a(),A(c,{key:0,value:o(e).tabs[o(e).currentTab].config.key,"onUpdate:value":t[0]||(t[0]=r=>o(e).tabs[o(e).currentTab].config.key=r),options:f.value,mode:"horizontal","dropdown-placement":"right-start"},null,8,["value","options"])):(a(),i("p",B,"You do not have access to any configuration pages"))])}}};const $={key:0},G={key:1,class:"config-box",style:{display:"flex","justify-content":"center","align-items":"center"}},U={__name:"index",setup(T){return(y,l)=>{const _=d("router-view"),f=d("n-result");return a(),i("div",null,[u(F),o(e).tabs[o(e).currentTab].config.anyAccess?(a(),i("div",$,[u(_,null,{default:h(({Component:s,route:t})=>[u(S,{name:"fade",mode:"out-in"},{default:h(()=>[(a(),A(E(s),{key:t.path}))]),_:2},1024)]),_:1})])):(a(),i("div",G,[u(f,{status:"403",title:"403 Forbidden",description:"Some of the doors are always close to you.",size:"huge"})]))])}}},H=R(U,[["__scopeId","data-v-26545441"]]);export{H as default};