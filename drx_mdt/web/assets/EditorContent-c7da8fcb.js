import{a2 as V,a3 as B,a4 as P,a5 as M,a6 as I,a7 as N,a8 as U,a9 as z,s as S,r as k,Z as H,o as X,E as K,S as $,a as F,c as W,b as p,d,k as y,m as h,w as m,F as C,n as L,e as _,y as O,f as j,t as Z,u as q,aa as G,i as J}from"./index-243f2949.js";const Q=V.create({name:"textStyle",addOptions(){return{HTMLAttributes:{}}},parseHTML(){return[{tag:"span",getAttrs:e=>e.hasAttribute("style")?{}:!1}]},renderHTML({HTMLAttributes:e}){return["span",B(this.options.HTMLAttributes,e),0]},addCommands(){return{removeEmptyTextStyle:()=>({state:e,commands:l})=>{const n=P(e,this.type);return Object.entries(n).some(([,t])=>!!t)?!0:l.unsetMark(this.name)}}}}),Y=M.create({name:"color",addOptions(){return{types:["textStyle"]}},addGlobalAttributes(){return[{types:this.options.types,attributes:{color:{default:null,parseHTML:e=>{var l;return(l=e.style.color)===null||l===void 0?void 0:l.replace(/['"]+/g,"")},renderHTML:e=>e.color?{style:`color: ${e.color}`}:{}}}}]},addCommands(){return{setColor:e=>({chain:l})=>l().setMark("textStyle",{color:e}).run(),unsetColor:()=>({chain:e})=>e().setMark("textStyle",{color:null}).removeEmptyTextStyle().run()}}}),ee=M.create({name:"placeholder",addOptions(){return{emptyEditorClass:"is-editor-empty",emptyNodeClass:"is-empty",placeholder:"Write something …",showOnlyWhenEditable:!0,showOnlyCurrent:!0,includeChildren:!1}},addProseMirrorPlugins(){return[new I({key:new N("placeholder"),props:{decorations:({doc:e,selection:l})=>{const n=this.editor.isEditable||!this.options.showOnlyWhenEditable,{anchor:o}=l,t=[];if(!n)return null;const c=e.type.createAndFill(),b=(c==null?void 0:c.sameMarkup(e))&&c.content.findDiffStart(e.content)===null;return e.descendants((u,i)=>{const s=o>=i&&o<=i+u.nodeSize,g=!u.isLeaf&&!u.childCount;if((s||!this.options.showOnlyCurrent)&&g){const f=[this.options.emptyNodeClass];b&&f.push(this.options.emptyEditorClass);const A=U.node(i,i+u.nodeSize,{class:f.join(" "),"data-placeholder":typeof this.options.placeholder=="function"?this.options.placeholder({editor:this.editor,node:u,pos:i,hasAnchor:s}):this.options.placeholder});t.push(A)}return this.options.includeChildren}),z.create(e,t)}}})]}});const te={key:0},ae={__name:"EditorContent",props:{modelValue:{type:String,default:""},disabled:{type:Boolean,default:!1},class:String,placeholder:String},emits:["update:modelValue"],setup(e,{emit:l}){const n=e,o=S.locale.EDITOR,t=k(null),c=k(null);H(()=>{t.value&&t.value.setOptions({editable:!n.disabled})}),H(()=>{t.value&&t.value.getHTML()!==n.modelValue&&t.value.commands.setContent(n.modelValue,!1)}),X(()=>{t.value=new K({editable:!n.disabled,extensions:[$,Q,Y,ee.configure({placeholder:n.placeholder})],content:n.modelValue,onUpdate:()=>{l("update:modelValue",t.value.getHTML())}})}),F(()=>{t.value.destroy()});const b=W(()=>[[{method:"toggleBold",label:o.BOLD,isActive:"bold",icon:"fa-bold"},{method:"toggleItalic",label:o.ITALIC,isActive:"italic",icon:"fa-italic"},{method:"toggleStrike",label:o.STRIKE,isActive:"strike",icon:"fa-strikethrough"}],{type:"select",options:[{method:"setParagraph",label:o.TEXT.PARAGRAPH,isActive:"paragraph",icon:"fa-paragraph"},{method:"toggleHeading",label:o.TEXT.H1,isActive:"heading",options:{level:1},icon:"fa-heading"},{method:"toggleHeading",label:o.TEXT.H2,isActive:"heading",options:{level:2},icon:"fa-heading"},{method:"toggleHeading",label:o.TEXT.H3,isActive:"heading",options:{level:3},icon:"fa-heading"},{method:"toggleHeading",label:o.TEXT.H4,isActive:"heading",options:{level:4},icon:"fa-heading"},{method:"toggleHeading",label:o.TEXT.H5,isActive:"heading",options:{level:5},icon:"fa-heading"},{method:"toggleHeading",label:o.TEXT.H6,isActive:"heading",options:{level:6},icon:"fa-heading"}]},{type:"select",label:o.COLOR,method:"setColor",isActive:"color",options:S.settings.editor.colors,icon:"fa-palette"},{method:"unsetAllMarks",label:o.CLEAR_MARKS,icon:"fa-broom"},{method:"clearNodes",label:o.CLEAR_NODES,icon:"fa-eraser"},{method:"toggleBulletList",label:o.BULLET_LIST,isActive:"bulletList",icon:"fa-list-ul"},{method:"toggleOrderedList",label:o.ORDERED_LIST,isActive:"orderedList",icon:"fa-list-ol"},{method:"setHardBreak",label:o.HARD_BREAK,icon:"fa-level-down-alt"},[{method:"undo",label:o.UNDO,icon:"fa-undo"},{method:"redo",label:o.REDO,icon:"fa-redo"}]]),u=(i,s)=>{if(t.value&&t.value.state.selection.$from.parent.inlineContent)try{return t.value.can().chain().focus()[i](s).run()}catch{return!1}else return!1};return(i,s)=>{const g=p("font-awesome-icon"),f=p("n-tooltip"),A=p("n-button"),T=p("n-select"),x=p("n-input-group"),w=p("n-space"),D=p("n-divider");return t.value?(d(),y("div",te,[h(w,{size:[3,3]},{default:m(()=>[(d(!0),y(C,null,L(b.value,(E,R)=>(d(),_(x,{key:`group-${R}`},{default:m(()=>[(d(!0),y(C,null,L(Array.isArray(E)?E:[E],a=>(d(),y(C,null,[a.type!=="select"&&a.type!=="colorPicker"?(d(),_(A,{key:0,onClick:r=>t.value.chain().focus()[a.method](a.options).run(),disabled:!u(a.method,a.options)||e.disabled,class:O({"is-active":a.isActive?t.value.isActive(a.isActive,a.options):!1}),type:t.value.can().chain().focus()[a.method](a.options).run()?"success":"error",tertiary:"",size:"small"},{default:m(()=>[h(f,{trigger:"hover"},{trigger:m(()=>[h(g,{icon:["fas",a.icon]},null,8,["icon"])]),default:m(()=>[j(" "+Z(a.label),1)]),_:2},1024)]),_:2},1032,["onClick","disabled","class","type"])):a.method==="setColor"?(d(),_(T,{key:1,options:a.options,"onUpdate:value":s[0]||(s[0]=r=>{t.value.chain().focus().setColor(r).run()}),disabled:e.disabled,size:"small",style:{"min-width":"150px"}},null,8,["options","disabled"])):(d(),_(T,{key:2,modelValue:c.value,"onUpdate:modelValue":s[1]||(s[1]=r=>c.value=r),options:a.options.map((r,v)=>({label:r.label,value:v})),"onUpdate:value":r=>{const v=a.options[r];t.value.chain().focus()[v.method](v.options).run()},disabled:e.disabled,size:"small",style:{"min-width":"150px"}},null,8,["modelValue","options","onUpdate:value","disabled"]))],64))),256))]),_:2},1024))),128))]),_:1}),h(D),h(q(G),{class:O([n.class,"editor-content"]),editor:t.value},null,8,["class","editor"])])):J("",!0)}}};export{ae as _};
