import{s as g,r as b,b as d,e as y,w as t,d as c,m as l,h as e,t as n,u as a,k as _,n as D,F as O}from"./index-243f2949.js";const x={__name:"index",setup(E){const s=g.locale.STAFF.CODES_COMMANDS,i=b({}),A=async()=>{try{const u=await(await fetch("../../configurables/10codes.json")).json();i.value=u}catch(o){console.error("An error occurred:",o)}},p=b({}),S=async()=>{try{const u=await(await fetch("../../configurables/commands.json")).json();p.value=u}catch(o){console.error("An error occurred:",o)}};return A(),S(),(o,u)=>{const f=d("n-table"),h=d("n-scrollbar"),C=d("n-gi"),M=d("n-grid");return c(),y(M,{cols:"2","x-gap":"10"},{default:t(()=>[l(C,{class:"box"},{default:t(()=>[e("h3",null,n(a(s).CODES.LABEL),1),l(h,{class:"scrollbar-10codes_commands"},{default:t(()=>[l(f,{striped:""},{default:t(()=>[e("thead",null,[e("tr",null,[e("th",null,n(a(s).CODES.CODE),1),e("th",null,n(a(s).CODES.DESCRIPTION),1)])]),e("tbody",null,[(c(!0),_(O,null,D(i.value,(r,m)=>(c(),_("tr",{key:m},[e("td",null,n(r[0]),1),e("td",null,n(r[1]),1)]))),128))])]),_:1})]),_:1})]),_:1}),l(C,{class:"box"},{default:t(()=>[e("h3",null,n(a(s).COMMANDS.LABEL),1),l(h,{class:"scrollbar-10codes_commands"},{default:t(()=>[l(f,{striped:""},{default:t(()=>[e("thead",null,[e("tr",null,[e("th",null,n(a(s).COMMANDS.COMMAND),1),e("th",null,n(a(s).COMMANDS.ACTION),1)])]),e("tbody",null,[(c(!0),_(O,null,D(p.value,(r,m)=>(c(),_("tr",{key:m},[e("td",null,n(r[0]),1),e("td",null,n(r[1]),1)]))),128))])]),_:1})]),_:1})]),_:1})]),_:1})}}};export{x as default};
