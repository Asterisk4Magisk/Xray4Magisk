import{c as Re,d as Ue,b as i,Y as jt,t as xt,l as Dt,Z as It,I as ze,f as Qe,r as f,h as ee,g as Ct,_ as Tt,i as Se,T as Ot,$ as At,a0 as St,a1 as Lt,w as Et,k as Yt,a2 as $t,n as _e,o as Rt,a3 as Ut,U as Qt,a4 as Pt,V as Bt,q as w,G as O,A as q,F as ne,z as u,a5 as Le,J as R,M as Ee,a6 as ie,x as _,a7 as Ht,L as Wt,y as g,B as Zt,C as Vt,H as Q,O as Ye,P as Gt,s as L,E as H,D as re,X as Jt}from"./index-CriPLLD7.js";import{s as G,b as Ft,c as Xt,a as qt,C as Kt,B as yt}from"./index-Df5zok-J.js";import{L as kt,a as el,Y as tl,F as ll}from"./index-ZxaD-jjV.js";import{S as al}from"./index-B87rnfS9.js";const[sl,$e]=Re("tag"),nl={size:String,mark:Boolean,show:xt,type:Dt("default"),color:String,plain:Boolean,round:Boolean,textColor:String,closeable:Boolean};var il=Ue({name:sl,props:nl,emits:["close"],setup(a,{slots:l,emit:e}){const t=C=>{C.stopPropagation(),e("close",C)},P=()=>a.plain?{color:a.textColor||a.color,borderColor:a.color}:{color:a.textColor,background:a.color},A=()=>{var C;const{type:E,mark:J,plain:F,round:W,size:j,closeable:x}=a,M={mark:J,plain:F,round:W};j&&(M[j]=j);const D=x&&i(ze,{name:"cross",class:[$e("close"),It],onClick:t},null);return i("span",{style:P(),class:$e([M,E])},[(C=l.default)==null?void 0:C.call(l),D])};return()=>i(jt,{name:a.closeable?"van-fade":void 0},{default:()=>[a.show?A():null]})}});const rl=Qe(il);function ol(a,l){let e=null,t=0;return function(...P){if(e)return;const A=Date.now()-t,C=()=>{t=Date.now(),e=!1,a.apply(this,P)};A>=l?C():e=setTimeout(C,l)}}const[ul,Ne]=Re("back-top"),cl={right:_e,bottom:_e,zIndex:_e,target:[String,Object],offset:Rt(200),immediate:Boolean,teleport:{type:[String,Object],default:"body"}};var dl=Ue({name:ul,inheritAttrs:!1,props:cl,emits:["click"],setup(a,{emit:l,slots:e,attrs:t}){let P=!1;const A=f(!1),C=f(),E=f(),J=ee(()=>Ct(Tt(a.zIndex),{right:Se(a.right),bottom:Se(a.bottom)})),F=M=>{var D;l("click",M),(D=E.value)==null||D.scrollTo({top:0,behavior:a.immediate?"auto":"smooth"})},W=()=>{A.value=E.value?Bt(E.value)>=+a.offset:!1},j=()=>{const{target:M}=a;if(typeof M=="string"){const D=document.querySelector(M);if(D)return D}else return M},x=()=>{Ut&&Qt(()=>{E.value=a.target?j():Pt(C.value),W()})};return Ot("scroll",ol(W,100),{target:E}),At(x),St(()=>{P&&(A.value=!0,P=!1)}),Lt(()=>{A.value&&a.teleport&&(A.value=!1,P=!0)}),Et(()=>a.target,x),()=>{const M=i("div",Yt({ref:a.teleport?void 0:C,class:Ne({active:A.value}),style:J.value,onClick:F},t),[e.default?e.default():i(ze,{name:"back-top",class:Ne("icon")},null)]);return a.teleport?[i("div",{ref:C,class:Ne("placeholder")},null),i($t,{to:a.teleport},{default:()=>[M]})]:M}}});const pl=Qe(dl),Pe=()=>({inbound:"",ip_version:"",network:"",auth_user:"",protocol:"",client:"",domain:"",domain_suffix:"",domain_keyword:"",domain_regex:"",source_ip_cidr:"",source_ip_is_private:"",ip_cidr:"",ip_is_private:"",source_port:"",source_port_range:"",port:"",port_range:"",process_name:"",process_path:"",process_path_regex:"",package_name:"",user:"",user_id:"",wifi_ssid:"",wifi_bssid:"",rule_set:"",rule_set_ip_cidr_match_source:"",invert:"",outbound:""}),Be=()=>({type:"",tag:"",format:"",path:"",url:"",download_detour:"",update_interval:""}),He=()=>({tag:"",address:"",address_resolver:"",address_strategy:"",strategy:"",detour:"",client_subnet:""}),We=()=>({inbound:"",ip_version:"",query_type:"",network:"",auth_user:"",protocol:"",domain:"",domain_suffix:"",domain_keyword:"",domain_regex:"",source_ip_cidr:"",source_ip_is_private:"",ip_cidr:"",ip_is_private:"",source_port:"",source_port_range:"",port:"",port_range:"",process_name:"",process_path:"",process_path_regex:"",package_name:"",user:"",user_id:"",wifi_ssid:"",wifi_bssid:"",rule_set:"",rule_set_ip_cidr_match_source:"",rule_set_ip_cidr_accept_empty:"",invert:"",outbound:"",server:"",disable_cache:"",client_subnet:""}),fl=a=>{let l=Pe();return Object.keys(a).forEach(e=>{e==="remarks"||e==="index"||e==="newRule"||a[e].length===0?l[e]=a[e]:l[e]=a[e].toString()}),l},gl=a=>{let l=Be();return Object.keys(a).forEach(e=>{e==="index"||e==="newRuleset"||a[e].length===0?l[e]=a[e]:l[e]=a[e].toString()}),l},vl=a=>{let l=He();return Object.keys(a).forEach(e=>{e==="index"||e==="newDns"||a[e].length===0?l[e]=a[e]:l[e]=a[e].toString()}),l},hl=a=>{let l=We();return Object.keys(a).forEach(e=>{e==="index"||e==="newDnsrule"||a[e].length===0?l[e]=a[e]:l[e]=a[e].toString()}),l},ml=a=>{Object.keys(a).forEach(l=>{if(l==="remarks"||l==="index"||l==="newRule"||a[l].length===0){delete a[l];return}if(l==="inbound"){let e=a[l].split(",");for(let t=0;t<e.length;t++)e[t]=e[t].trim();a[l]=e;return}if(l==="ip_version"){a[l]=parseInt(a[l]);return}if(l==="network"){let e=a[l].split(",");for(let t=0;t<e.length;t++)e[t]=e[t].trim();a[l]=e;return}if(l==="auth_user"){let e=a[l].split(",");for(let t=0;t<e.length;t++)e[t]=e[t].trim();a[l]=e;return}if(l==="protocol"){let e=a[l].split(",");for(let t=0;t<e.length;t++)e[t]=e[t].trim();a[l]=e;return}if(l==="client"){let e=a[l].split(",");for(let t=0;t<e.length;t++)e[t]=e[t].trim();a[l]=e;return}if(l==="domain"){let e=a[l].split(",");for(let t=0;t<e.length;t++)e[t]=e[t].trim();a[l]=e;return}if(l==="domain_suffix"){let e=a[l].split(",");for(let t=0;t<e.length;t++)e[t]=e[t].trim();a[l]=e;return}if(l==="domain_keyword"){let e=a[l].split(",");for(let t=0;t<e.length;t++)e[t]=e[t].trim();a[l]=e;return}if(l==="domain_regex"){let e=a[l].split(",");for(let t=0;t<e.length;t++)e[t]=e[t].trim();a[l]=e;return}if(l==="source_ip_cidr"){let e=a[l].split(",");for(let t=0;t<e.length;t++)e[t]=e[t].trim();a[l]=e;return}if(l==="source_ip_is_private"){a[l]=JSON.parse(a[l]);return}if(l==="ip_cidr"){let e=a[l].split(",");for(let t=0;t<e.length;t++)e[t]=e[t].trim();a[l]=e;return}if(l==="ip_is_private"){a[l]=JSON.parse(a[l]);return}if(l==="source_port"){let e=[];for(let t of a[l].split(","))e.push(parseInt(t.trim()));a[l]=e;return}if(l==="source_port_range"){let e=a[l].split(",");for(let t=0;t<e.length;t++)e[t]=e[t].trim();a[l]=e;return}if(l==="port"){let e=[];for(let t of a[l].split(","))e.push(parseInt(t.trim()));a[l]=e;return}if(l==="port_range"){let e=a[l].split(",");for(let t=0;t<e.length;t++)e[t]=e[t].trim();a[l]=e;return}if(l==="process_name"){let e=a[l].split(",");for(let t=0;t<e.length;t++)e[t]=e[t].trim();a[l]=e;return}if(l==="process_path"){let e=a[l].split(",");for(let t=0;t<e.length;t++)e[t]=e[t].trim();a[l]=e;return}if(l==="process_path_regex"){let e=a[l].split(",");for(let t=0;t<e.length;t++)e[t]=e[t].trim();a[l]=e;return}if(l==="package_name"){let e=a[l].split(",");for(let t=0;t<e.length;t++)e[t]=e[t].trim();a[l]=e;return}if(l==="user"){let e=a[l].split(",");for(let t=0;t<e.length;t++)e[t]=e[t].trim();a[l]=e;return}if(l==="user_id"){let e=[];for(let t of a[l].split(","))e.push(parseInt(t.trim()));a[l]=e;return}if(l==="wifi_ssid"){let e=a[l].split(",");for(let t=0;t<e.length;t++)e[t]=e[t].trim();a[l]=e;return}if(l==="wifi_bssid"){let e=a[l].split(",");for(let t=0;t<e.length;t++)e[t]=e[t].trim();a[l]=e;return}if(l==="rule_set"){let e=a[l].split(",");for(let t=0;t<e.length;t++)e[t]=e[t].trim();a[l]=e;return}if(l==="rule_set_ip_cidr_match_source"){a[l]=JSON.parse(a[l]);return}if(l==="invert"){a[l]=JSON.parse(a[l]);return}})},Ml=a=>{Object.keys(a).forEach(l=>{(l==="index"||l==="newRuleset"||a[l].length===0)&&delete a[l]})},wl=a=>{Object.keys(a).forEach(l=>{(l==="index"||l==="newDns"||a[l].length===0)&&delete a[l]})},_l=a=>{Object.keys(a).forEach(l=>{if(l==="index"||l==="newDnsrule"||a[l].length===0){delete a[l];return}if(l==="inbound"){let e=a[l].split(",");for(let t=0;t<e.length;t++)e[t]=e[t].trim();a[l]=e;return}if(l==="ip_version"){a[l]=parseInt(a[l]);return}if(l==="query_type"){let e=a[l].split(",");for(let t=0;t<e.length;t++)e[t]=e[t].trim();a[l]=e;return}if(l==="auth_user"){let e=a[l].split(",");for(let t=0;t<e.length;t++)e[t]=e[t].trim();a[l]=e;return}if(l==="protocol"){let e=a[l].split(",");for(let t=0;t<e.length;t++)e[t]=e[t].trim();a[l]=e;return}if(l==="domain"){let e=a[l].split(",");for(let t=0;t<e.length;t++)e[t]=e[t].trim();a[l]=e;return}if(l==="domain_suffix"){let e=a[l].split(",");for(let t=0;t<e.length;t++)e[t]=e[t].trim();a[l]=e;return}if(l==="domain_keyword"){let e=a[l].split(",");for(let t=0;t<e.length;t++)e[t]=e[t].trim();a[l]=e;return}if(l==="domain_regex"){let e=a[l].split(",");for(let t=0;t<e.length;t++)e[t]=e[t].trim();a[l]=e;return}if(l==="source_ip_cidr"){let e=a[l].split(",");for(let t=0;t<e.length;t++)e[t]=e[t].trim();a[l]=e;return}if(l==="source_ip_is_private"){a[l]=JSON.parse(a[l]);return}if(l==="ip_cidr"){let e=a[l].split(",");for(let t=0;t<e.length;t++)e[t]=e[t].trim();a[l]=e;return}if(l==="ip_is_private"){a[l]=JSON.parse(a[l]);return}if(l==="source_port"){let e=[];for(let t of a[l].split(","))e.push(parseInt(t.trim()));a[l]=e;return}if(l==="source_port_range"){let e=a[l].split(",");for(let t=0;t<e.length;t++)e[t]=e[t].trim();a[l]=e;return}if(l==="port"){let e=[];for(let t of a[l].split(","))e.push(parseInt(t.trim()));a[l]=e;return}if(l==="port_range"){let e=a[l].split(",");for(let t=0;t<e.length;t++)e[t]=e[t].trim();a[l]=e;return}if(l==="process_name"){let e=a[l].split(",");for(let t=0;t<e.length;t++)e[t]=e[t].trim();a[l]=e;return}if(l==="process_path"){let e=a[l].split(",");for(let t=0;t<e.length;t++)e[t]=e[t].trim();a[l]=e;return}if(l==="process_path_regex"){let e=a[l].split(",");for(let t=0;t<e.length;t++)e[t]=e[t].trim();a[l]=e;return}if(l==="package_name"){let e=a[l].split(",");for(let t=0;t<e.length;t++)e[t]=e[t].trim();a[l]=e;return}if(l==="user"){let e=a[l].split(",");for(let t=0;t<e.length;t++)e[t]=e[t].trim();a[l]=e;return}if(l==="user_id"){let e=[];for(let t of a[l].split(","))e.push(parseInt(t.trim()));a[l]=e;return}if(l==="wifi_ssid"){let e=a[l].split(",");for(let t=0;t<e.length;t++)e[t]=e[t].trim();a[l]=e;return}if(l==="wifi_bssid"){let e=a[l].split(",");for(let t=0;t<e.length;t++)e[t]=e[t].trim();a[l]=e;return}if(l==="rule_set"){let e=a[l].split(",");for(let t=0;t<e.length;t++)e[t]=e[t].trim();a[l]=e;return}if(l==="rule_set_ip_cidr_match_source"){a[l]=JSON.parse(a[l]);return}if(l==="rule_set_ip_cidr_accept_empty"){a[l]=JSON.parse(a[l]);return}if(l==="invert"){a[l]=JSON.parse(a[l]);return}if(l==="outbound"){let e=a[l].split(",");for(let t=0;t<e.length;t++)e[t]=e[t].trim();a[l]=e;return}if(l==="disable_cache"){a[l]=JSON.parse(a[l]);return}})},Ze=()=>({domainMatcher:"",type:"",domain:"",ip:"",port:"",sourcePort:"",network:"",source:"",user:"",inboundTag:"",protocol:"",outboundTag:"",balancerTag:"",ruleTag:""}),Ve=()=>({address:"",port:"",domains:"",expectIPs:"",skipFallback:"",clientIP:""}),Nl=a=>{let l=Ze();return Object.keys(a).forEach(e=>{e==="remarks"||e==="index"||e==="newRule"||a[e].length===0?l[e]=a[e]:l[e]=a[e].toString()}),l},zl=a=>{let l=Ve();return typeof a=="string"?l.address=a:Object.keys(a).forEach(e=>{e==="index"||e==="newDns"||a[e].length===0?l[e]=a[e]:l[e]=a[e].toString()}),l},bl=a=>{Object.keys(a).forEach(l=>{if(l==="remarks"||l==="index"||l==="newRule"||a[l].length===0){delete a[l];return}if(l==="domain"){let e=a[l].split(",");for(let t=0;t<e.length;t++)e[t]=e[t].trim();a[l]=e;return}if(l==="ip"){let e=a[l].split(",");for(let t=0;t<e.length;t++)e[t]=e[t].trim();a[l]=e;return}if(l==="source"){let e=a[l].split(",");for(let t=0;t<e.length;t++)e[t]=e[t].trim();a[l]=e;return}if(l==="user"){let e=a[l].split(",");for(let t=0;t<e.length;t++)e[t]=e[t].trim();a[l]=e;return}if(l==="inboundTag"){let e=a[l].split(",");for(let t=0;t<e.length;t++)e[t]=e[t].trim();a[l]=e;return}if(l==="protocol"){let e=a[l].split(",");for(let t=0;t<e.length;t++)e[t]=e[t].trim();a[l]=e;return}})},jl=a=>{Object.keys(a).forEach(l=>{if(l==="index"||l==="newDns"||a[l].length===0){delete a[l];return}if(l==="port"){a[l]=parseInt(a[l]);return}if(l==="domains"){let e=a[l].split(",");for(let t=0;t<e.length;t++)e[t]=e[t].trim();a[l]=e;return}if(l==="expectIPs"){let e=a[l].split(",");for(let t=0;t<e.length;t++)e[t]=e[t].trim();a[l]=e;return}if(l==="skipFallback"){a[l]=JSON.parse(a[l]);return}})},xl={key:0},Dl=["src"],Il={key:1},Cl={class:"custom-title"},Tl={class:"custom-title"},Ol={class:"custom-title"},Al={class:"custom-title"},Sl={class:"custom-title"},Ll={class:"custom-title"},Ql={__name:"Manage",props:["theme"],setup(a){const l=f("http://127.0.0.1:65532/ui"),e=f("/data/adb/xray/data"),t=f(""),P=f(!1),A=[{text:w.global.t("manage.edit-custom"),value:"edit-custom",disabled:!1},{text:w.global.t("manage.dns-manage"),value:"dns",disabled:!1},{text:w.global.t("manage.rule-manage"),value:"rule",disabled:!1}],C=s=>{s.value==="edit-custom"?be():s.value==="rule"?le():s.value==="ruleset"?fe():s.value==="dns"?he():s.value==="dnsrule"&&ae()},E=f(!1),J=f(!1),F=f(""),W=f(!1),j=f([]),x=f([]);let M=!0;const D=f([]),K=f([]),oe=f(!1),be=()=>{Ye(`${e.value}/custom.txt`).then(s=>{K.value=s.trim().split(/\s+/),oe.value=!0}).catch(()=>{Ee("",`${e.value}/custom.txt`).then(()=>{be()})})},Ge=(s,n)=>{K.value[n]=s},Je=s=>{K.value.splice(s,1)},Fe=()=>{K.value.push("")},Xe=()=>{let s="";for(let n of K.value)s=s+n+`
`;Ee(s,`${e.value}/custom.txt`),Ae()},d=f([]),I=f(0),qe=ee(()=>{let s={};return Object.assign(s,d.value[I.value]),delete s.remarks,delete s.index,delete s.newRule,delete s.outbound,delete s.outboundTag,s}),Ke=ee(()=>{let s=[];return s.push({remarks:"direct(builtin)",index:"direct",virtual:!0}),s.push({remarks:"block(builtin)",index:"block",virtual:!0}),s.push({remarks:"proxy(builtin)",index:"proxy",virtual:!0}),s.push(...j.value),s}),ue=f(!1),ce=f(!1),te=f(!1),le=()=>{ue.value=!0,_("get rule").then(s=>{d.value=s.result;for(let n=0;n<d.value.length;n++)if(d.value[n].index=n,d.value[n].newRule=!1,t.value==="xray"){if(d.value[n]=Nl(d.value[n]),d.value[n].remarks=d.value[n].outboundTag,d.value[n].outboundTag.startsWith("xrayhelper-")){let o=y(parseInt(d.value[n].outboundTag.replace("xrayhelper-","")),!1);o&&(d.value[n].remarks=o.remarks)}else if(d.value[n].outboundTag.startsWith("xrayhelpercustom-")){let o=y(parseInt(d.value[n].outboundTag.replace("xrayhelpercustom-","")),!0);o&&(d.value[n].remarks=o.remarks)}}else if(t.value==="sing-box"){if(d.value[n]=fl(d.value[n]),d.value[n].remarks=d.value[n].outbound,d.value[n].outbound.startsWith("xrayhelper-")){let o=y(parseInt(d.value[n].outbound.replace("xrayhelper-","")),!1);o&&(d.value[n].remarks=o.remarks)}else if(d.value[n].outbound.startsWith("xrayhelpercustom-")){let o=y(parseInt(d.value[n].outbound.replace("xrayhelpercustom-","")),!0);o&&(d.value[n].remarks=o.remarks)}}})},ye=()=>{let s;t.value==="xray"?s=Ze():t.value==="sing-box"&&(s=Pe()),s.index=d.value.length,s.newRule=!0,d.value.push(s),je(d.value.length-1)},je=s=>{I.value=s,ce.value=!0},ke=s=>{let n;s.virtual?(n=s.index,d.value[I.value].remarks=s.remarks):s.custom?(n="xrayhelpercustom-"+s.index,d.value[I.value].remarks=y(s.index,!0).remarks):(n="xrayhelper-"+s.index,d.value[I.value].remarks=y(s.index,!1).remarks),t.value==="xray"?d.value[I.value].outboundTag=n:t.value==="sing-box"&&(d.value[I.value].outbound=n),te.value=!1},xe=async(s,n)=>{await _(`exchange rule ${s} ${n}`),le()},et=async s=>{await _(`delete rule ${s}`),le()},tt=async()=>{let s=[];d.value[I.value].newRule?(s.push("add"),s.push("rule")):(s.push("set"),s.push("rule"),s.push(`${d.value[I.value].index}`)),t.value==="xray"?bl(d.value[I.value]):t.value==="sing-box"&&ml(d.value[I.value]),s.push(`${ie.Buffer.from(JSON.stringify(d.value[I.value])).toString("base64")}`),await _(s),I.value=0,le()},N=f([]),Z=f(0),lt=ee(()=>{let s={};return Object.assign(s,N.value[Z.value]),delete s.index,delete s.newRuleset,s}),de=f(!1),pe=f(!1),fe=()=>{de.value=!0,_("get ruleset").then(s=>{N.value=s.result;for(let n=0;n<N.value.length;n++)N.value[n].index=n,N.value[n].newRuleset=!1,N.value[n]=gl(N.value[n])})},at=()=>{let s=Be();s.index=N.value.length,s.newRuleset=!0,N.value.push(s),De(N.value.length-1)},De=s=>{Z.value=s,pe.value=!0},st=async s=>{await _(`delete ruleset ${s}`),fe()},nt=async()=>{let s=[];N.value[Z.value].newRuleset?(s.push("add"),s.push("ruleset")):(s.push("set"),s.push("ruleset"),s.push(`${N.value[Z.value].index}`)),Ml(N.value[Z.value]),s.push(`${ie.Buffer.from(JSON.stringify(N.value[Z.value])).toString("base64")}`),await _(s),Z.value=0,fe()},m=f([]),Y=f(0),it=ee(()=>{let s={};return Object.assign(s,m.value[Y.value]),delete s.index,delete s.newDns,s}),ge=f(!1),ve=f(!1),he=()=>{ge.value=!0,_("get dns").then(s=>{m.value=s.result;for(let n=0;n<m.value.length;n++)t.value==="xray"?m.value[n]=zl(m.value[n]):t.value==="sing-box"&&(m.value[n]=vl(m.value[n])),m.value[n].index=n,m.value[n].newDns=!1})},rt=()=>{let s;t.value==="xray"?s=Ve():t.value==="sing-box"&&(s=He()),s.index=m.value.length,s.newDns=!0,m.value.push(s),Ie(m.value.length-1)},Ie=s=>{Y.value=s,ve.value=!0},ot=async s=>{await _(`delete dns ${s}`),he()},ut=async()=>{let s=[];if(m.value[Y.value].newDns?(s.push("add"),s.push("dns")):(s.push("set"),s.push("dns"),s.push(`${m.value[Y.value].index}`)),t.value==="xray"){jl(m.value[Y.value]);let n=Object.keys(m.value[Y.value]);n.length===1&&n[0]==="address"&&(m.value[Y.value]=m.value[Y.value].address)}else t.value==="sing-box"&&wl(m.value[Y.value]);s.push(`${ie.Buffer.from(JSON.stringify(m.value[Y.value])).toString("base64")}`),await _(s),Y.value=0,he()},z=f([]),V=f(0),ct=ee(()=>{let s={};return Object.assign(s,z.value[V.value]),delete s.index,delete s.newDnsrule,s}),me=f(!1),Me=f(!1),ae=()=>{me.value=!0,_("get dnsrule").then(s=>{z.value=s.result;for(let n=0;n<z.value.length;n++)z.value[n]=hl(z.value[n]),z.value[n].index=n,z.value[n].newDnsrule=!1})},dt=()=>{let s=We();s.index=z.value.length,s.newDnsrule=!0,z.value.push(s),Ce(z.value.length-1)},Ce=s=>{V.value=s,Me.value=!0},Te=async(s,n)=>{await _(`exchange dnsrule ${s} ${n}`),ae()},pt=async s=>{await _(`delete dnsrule ${s}`),ae()},ft=async()=>{let s=[];z.value[V.value].newDnsrule?(s.push("add"),s.push("dnsrule")):(s.push("set"),s.push("dnsrule"),s.push(`${z.value[V.value].index}`)),_l(z.value[V.value]),s.push(`${ie.Buffer.from(JSON.stringify(z.value[V.value])).toString("base64")}`),await _(s),V.value=0,ae()},gt=s=>{s.switchLoading=!0,localStorage.setItem("lastSelected",s.hashId);let n=s.custom?`set switch custom ${s.index}`:`set switch ${s.index}`;_(n).then(o=>{o.ok?G(w.global.t("dashboard.tool-switch-success")):G(w.global.t("dashboard.tool-switch-failed"));for(const v of j.value)v.selected&&(v.selected=!1);s.selected=!0}).finally(()=>{s.switchLoading=!1})},vt=s=>{console.info("searchNode"),Ft({duration:0,forbidClick:!0,message:w.global.t("manage.search")}),setTimeout(()=>{try{if(console.info(`allNodeList:${j.value.length}`),x.value.length=0,s==="")x.value.push(...j.value);else{const n=j.value.filter(o=>o.remarks.includes(s));x.value.push(...n)}console.info(`showNodeList:${x.value.length}`)}catch(n){console.error(n)}Xt()},50)},y=(s,n)=>j.value.filter(o=>o.custom===n&&o.index===s)[0];let se=null;const ht=(s,n=1e3,o=!1)=>function(){se&&(console.info("清除定时器"),clearTimeout(se)),o&&!se&&s.apply(this,arguments),se=setTimeout(()=>{s.apply(this,arguments)},n)},mt=()=>{M?el({message:w.global.t("manage.speedtest-all-warn")}).then(()=>{Mt()}).catch(()=>{}):G(w.global.t("manage.speedtest-reject"))},Mt=async()=>{const s=x.value.filter(o=>o.custom);D.value=[...s],await we(!0);const n=x.value.filter(o=>!o.custom);D.value=[...n],await we(!1)},we=async s=>{if(console.info("startSpeedtest"),M){M=!1;let n=[],o=[...D.value];if(D.value.length=0,o.length===0){M=!0;return}for(const p of o)p.speedtestLoading=!0,n.push(p.index);let v=s?`misc realping custom ${n.join(" ")}`:`misc realping ${n.join(" ")}`;await _(v).then(p=>{let S=new Map(p.result.map(b=>[b.index,b.realping]));for(const b of o){b.speedtestLoading=!1;let X=S.get(b.index.toString()),U;X===-1?U="#646566":X<500?U="#07c160":X<1e3?U="#d4b75c":X<2e3?U="#e67f3c":U="#ee0a24",b.ping=`${X} ms`,b.color=U,b.show=!0}}).catch(p=>{G(w.global.t("manage.speedtest-failed")+p)}).finally(()=>{for(const p of o)p.speedtestLoading=!1;o.length=0,M=!0})}},wt=s=>{if(s.speedtestLoading===!0||D.value.length>0&&D.value[0].custom!==s.custom){G(w.global.t("manage.speedtest-reject"));return}D.value.push(s),s.speedtestLoading=!0,ht(()=>{we(s.custom)},1500,!1)(),console.info("clickSpeedtest complete")},_t=(s,n=0)=>{let o=3735928559^n,v=1103547991^n;for(let p=0,S;p<s.length;p++)S=s.charCodeAt(p),o=Math.imul(o^S,2654435761),v=Math.imul(v^S,1597334677);return o=Math.imul(o^o>>>16,2246822507)^Math.imul(v^v>>>13,3266489909),v=Math.imul(v^v>>>16,2246822507)^Math.imul(o^o>>>13,3266489909),4294967296*(2097151&v)+(o>>>0)},Oe=(s,n)=>{const o=[],v=localStorage.getItem("lastSelected");for(let p=0;p<s.length;p++)s[p].switchLoading=!1,s[p].speedtestLoading=!1,s[p].show=!1,s[p].ping="-",s[p].color="#646566",s[p].custom=n,s[p].index=p,s[p].hashId=_t(JSON.stringify(s[p])),s[p].selected=v==s[p].hashId,o.push(s[p]);return o},Nt=async()=>{await _("get switch all").then(s=>{if(s.custom.length>0){const o=Oe(s.custom,!0);j.value.push(...o),x.value.push(...o)}const n=Oe(s.result,!1);j.value.push(...n),x.value.push(...n),console.info("initXrayData complete")}).catch(s=>{G(w.global.t("manage.load-switch-data-failed")+s)})},Ae=async()=>{console.info("onLoad"),E.value=!0,J.value=!1,x.value=[],j.value=[],await Nt(),E.value=!1,J.value=!0},zt=async()=>await Ye(Jt).then(s=>tl.parse(s)).catch(s=>{G(w.global.t("setting.cannot-get-config")+s)});return(()=>{zt().then(s=>{let n=s.clash.panelUrl;n&&(l.value=n);let o=s.xrayHelper.dataDir;o&&(e.value=o);let v=s.xrayHelper.coreType;v==="v2ray"||v==="hysteria2"?G(w.global.t("manage.not-support")):v&&(t.value=v,v==="sing-box"&&(A.push({text:w.global.t("manage.dnsrule-manage"),value:"dnsrule",disabled:!1}),A.push({text:w.global.t("manage.ruleset-manage"),value:"ruleset",disabled:!1})),(v==="xray"||v==="sing-box")&&Ae())})})(),(s,n)=>{const o=ze,v=Gt,p=ll,S=qt,b=al,X=Ht,U=rl,T=yt,$=Kt,bt=pl,k=kt,B=Wt;return g(),O(R,null,[t.value==="mihomo"?(g(),O("div",xl,[q("iframe",{src:l.value,style:{"min-height":"88vh","min-width":"100vw"},frameborder:"no",border:"0",marginwidth:"0",marginheight:"0",scrolling:"no",allowtransparency:"yes"},null,8,Dl)])):ne("",!0),t.value==="xray"||t.value==="sing-box"?(g(),O("div",Il,[i(X,{style:{top:"46px"},fixed:""},{left:u(()=>[i(v,{show:P.value,"onUpdate:show":n[0]||(n[0]=r=>P.value=r),actions:A,onSelect:C,placement:"bottom-start"},{reference:u(()=>[i(o,{name:"wap-nav",size:"1.2rem"})]),_:1},8,["show"])]),title:u(()=>[i(S,{inset:""},{default:u(()=>[Zt(i(p,{modelValue:F.value,"onUpdate:modelValue":n[2]||(n[2]=r=>F.value=r),center:"",clearable:"",placeholder:Le(w).global.t("manage.placeholder-text")},{button:u(()=>[i(o,{name:"search",size:"1.1rem",onClick:n[1]||(n[1]=r=>vt(F.value))})]),_:1},8,["modelValue","placeholder"]),[[Vt,W.value]])]),_:1})]),right:u(()=>[i(b,{wrap:""},{default:u(()=>[i(o,{name:"data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxZW0iIGhlaWdodD0iMWVtIiB2aWV3Qm94PSIwIDAgMjQgMjQiPjxwYXRoIGZpbGw9IiMxOTg5ZmEiIGQ9Ik0xMSA5LjQ3VjExaDMuNzZMMTMgMTQuNTNWMTNIOS4yNHpNMTMgMUw2IDE1aDV2OGw3LTE0aC01eiIvPjwvc3ZnPg==",size:"1.2rem",onClick:n[3]||(n[3]=r=>mt())}),i(o,{name:"filter-o",size:"1.2rem",onClick:n[4]||(n[4]=r=>W.value=!W.value)})]),_:1})]),_:1}),i(k,{loading:E.value,"onUpdate:loading":n[5]||(n[5]=r=>E.value=r),finished:J.value,"finished-text":Le(w).global.t("manage.no-more")},{default:u(()=>[i(S,{style:{top:"46px"}},{default:u(()=>[(g(!0),O(R,null,Q(x.value,(r,c)=>(g(),L($,{key:c,center:""},{title:u(()=>[q("span",Cl,H(r.remarks),1)]),label:u(()=>[i(b,{fill:""},{default:u(()=>[r.custom?(g(),L(U,{key:0,style:{"white-space":"nowrap"},color:"#6f3381"},{default:u(()=>n[17]||(n[17]=[re("Custom")])),_:1})):ne("",!0),i(U,{style:{"white-space":"nowrap"},color:"#1989fa"},{default:u(()=>[re(H(r.type),1)]),_:2},1024),i(U,{style:{"white-space":"nowrap"},color:"#1989fa"},{default:u(()=>[re(H(r.protocol),1)]),_:2},1024),r.show?(g(),L(U,{key:1,style:{"white-space":"nowrap"},color:r.color},{default:u(()=>[re(H(r.ping),1)]),_:2},1032,["color"])):ne("",!0)]),_:2},1024),q("span",Tl,H(r.host)+":"+H(r.port),1)]),value:u(()=>[i(b,null,{default:u(()=>[i(T,{plain:"",hairline:"",type:"default",size:"small",icon:"data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxZW0iIGhlaWdodD0iMWVtIiB2aWV3Qm94PSIwIDAgMjQgMjQiPjxwYXRoIGZpbGw9IiMxOTg5ZmEiIGQ9Ik0xMSA5LjQ3VjExaDMuNzZMMTMgMTQuNTNWMTNIOS4yNHpNMTMgMUw2IDE1aDV2OGw3LTE0aC01eiIvPjwvc3ZnPg==",loading:r.speedtestLoading,onClick:h=>wt(r)},null,8,["loading","onClick"]),i(T,{plain:"",hairline:"",type:"default",size:"small",icon:r.selected?"data:image/svg+xml;base64,PHN2ZyB0PSIxNzI3NjI2OTM1ODI3IiBjbGFzcz0iaWNvbiIgdmlld0JveD0iMCAwIDEwMjQgMTAyNCIgdmVyc2lvbj0iMS4xIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHAtaWQ9IjE2NzIyIiB3aWR0aD0iMjAwIiBoZWlnaHQ9IjIwMCI+PHBhdGggZD0iTTgyOS40MTg2NjcgMjUzLjQxODY2N2E2NCA2NCAwIDAgMSA5My4zNzYgODcuNDI0bC0yLjg4IDMuMDcyLTQ2OS4zMzMzMzQgNDY5LjMzMzMzM2E2NCA2NCAwIDAgMS04Ny40MjQgMi44OGwtMy4wNzItMi44OC0yNTYtMjU2YTY0IDY0IDAgMCAxIDg3LjQyNC05My4zNzZsMy4wNzIgMi44OEw0MDUuMzMzMzMzIDY3Ny40ODI2NjdsNDI0LjA4NTMzNC00MjQuMDY0eiIgZmlsbD0iIzE5ODlmYSIgcC1pZD0iMTY3MjMiPjwvcGF0aD48L3N2Zz4=":"data:image/svg+xml;base64,PHN2ZyB0PSIxNzI3NjI3MDIwOTE2IiBjbGFzcz0iaWNvbiIgdmlld0JveD0iMCAwIDEwMjQgMTAyNCIgdmVyc2lvbj0iMS4xIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHAtaWQ9IjE3NzkzIiB3aWR0aD0iMjAwIiBoZWlnaHQ9IjIwMCI+PHBhdGggZD0iTTk2MCA1MTJjMCA4Ny43ODY2NjctMjAuNTIyNjY3IDE2Ni44MjY2NjctNTcuNjIxMzMzIDIzMy4xOTQ2NjdhNDA1LjcxNzMzMyA0MDUuNzE3MzMzIDAgMCAxLTE1Ny4xODQgMTU3LjE4NEM2NzguODQ4IDkzOS40OTg2NjcgNTk5Ljc4NjY2NyA5NjAgNTEyIDk2MGMtODcuNzg2NjY3IDAtMTY2LjgyNjY2Ny0yMC41MjI2NjctMjMzLjE5NDY2Ny01Ny42MjEzMzNBNDA1LjcxNzMzMyA0MDUuNzE3MzMzIDAgMCAxIDEyMS42IDc0NS4xOTQ2NjdDODQuNTAxMzMzIDY3OC44NDggNjQgNTk5Ljc4NjY2NyA2NCA1MTJjMC04Ny43ODY2NjcgMjAuNTIyNjY3LTE2Ni44MjY2NjcgNTcuNjIxMzMzLTIzMy4xOTQ2NjdBNDA1LjcxNzMzMyA0MDUuNzE3MzMzIDAgMCAxIDI3OC44MDUzMzMgMTIxLjZDMzQ1LjE1MiA4NC41MDEzMzMgNDI0LjIxMzMzMyA2NCA1MTIgNjRjODcuNzg2NjY3IDAgMTY2LjgyNjY2NyAyMC41MjI2NjcgMjMzLjE5NDY2NyA1Ny42MjEzMzNhNDA1LjcxNzMzMyA0MDUuNzE3MzMzIDAgMCAxIDE1Ny4xODQgMTU3LjE4NEM5MzkuNDk4NjY3IDM0NS4xNTIgOTYwIDQyNC4yMTMzMzMgOTYwIDUxMnogbS04NS4zMzMzMzMgMGMwLTcyLjAyMTMzMy0xNi4yNTYtMTM2Ljk4MTMzMy00Ni43NjI2NjctMTkxLjU3MzMzM2EzMjAuMzg0IDMyMC4zODQgMCAwIDAtMTI0LjM1Mi0xMjQuMzMwNjY3QzY0OC45ODEzMzMgMTY1LjU4OTMzMyA1ODQuMDIxMzMzIDE0OS4zMzMzMzMgNTEyIDE0OS4zMzMzMzNjLTcyLjAyMTMzMyAwLTEzNi45ODEzMzMgMTYuMjU2LTE5MS41NzMzMzMgNDYuNzYyNjY3YTMyMC4zODQgMzIwLjM4NCAwIDAgMC0xMjQuMzMwNjY3IDEyNC4zNTJDMTY1LjU4OTMzMyAzNzUuMDE4NjY3IDE0OS4zMzMzMzMgNDM5Ljk3ODY2NyAxNDkuMzMzMzMzIDUxMmMwIDcyLjAyMTMzMyAxNi4yNTYgMTM2Ljk4MTMzMyA0Ni43NjI2NjcgMTkxLjU3MzMzM2EzMjAuMzg0IDMyMC4zODQgMCAwIDAgMTI0LjM1MiAxMjQuMzMwNjY3QzM3NS4wMTg2NjcgODU4LjQxMDY2NyA0MzkuOTc4NjY3IDg3NC42NjY2NjcgNTEyIDg3NC42NjY2NjdjNzIuMDIxMzMzIDAgMTM2Ljk4MTMzMy0xNi4yNTYgMTkxLjU3MzMzMy00Ni43NjI2NjdhMzIwLjM4NCAzMjAuMzg0IDAgMCAwIDEyNC4zMzA2NjctMTI0LjM1MkM4NTguNDEwNjY3IDY0OC45ODEzMzMgODc0LjY2NjY2NyA1ODQuMDIxMzMzIDg3NC42NjY2NjcgNTEyeiIgZmlsbD0iIzE5ODlmYSIgcC1pZD0iMTc3OTQiPjwvcGF0aD48L3N2Zz4=",loading:r.switchLoading,onClick:h=>gt(r)},null,8,["icon","loading","onClick"])]),_:2},1024)]),_:2},1024))),128)),i(bt,{bottom:"10vh",immediate:""})]),_:1})]),_:1},8,["loading","finished","finished-text"]),i(B,{show:oe.value,"onUpdate:show":n[6]||(n[6]=r=>oe.value=r),round:"",style:{width:"90%",maxHeight:"85%"},onClosed:Xe},{default:u(()=>[i($,{title:s.$t("manage.edit-custom"),"title-style":"max-width:100%;"},{"right-icon":u(()=>[i(o,{size:"1.2rem",name:"plus",onClick:Fe})]),_:1},8,["title"]),i(k,null,{default:u(()=>[(g(!0),O(R,null,Q(K.value,(r,c)=>(g(),L(p,{label:c+":",labelWidth:"1.5em","model-value":r,"onUpdate:modelValue":h=>Ge(h,c)},{"right-icon":u(()=>[i(o,{size:"1rem",name:"cross",onClick:h=>Je(c)},null,8,["onClick"])]),_:2},1032,["label","model-value","onUpdate:modelValue"]))),256))]),_:1})]),_:1},8,["show"]),i(B,{show:ue.value,"onUpdate:show":n[7]||(n[7]=r=>ue.value=r),round:"",style:{width:"90%",maxHeight:"85%"}},{default:u(()=>[i($,{title:s.$t("manage.rule-manage"),"title-style":"max-width:100%;"},{"right-icon":u(()=>[i(o,{size:"1.2rem",name:"plus",onClick:ye})]),_:1},8,["title"]),i(S,null,{default:u(()=>[(g(!0),O(R,null,Q(d.value,(r,c)=>(g(),L($,{key:c,center:""},{title:u(()=>[q("span",Ol,H(r.remarks),1)]),value:u(()=>[i(b,null,{default:u(()=>[i(T,{plain:"",hairline:"",type:"default",size:"small",icon:"arrow-up",onClick:h=>xe(c,c-1)},null,8,["onClick"]),i(T,{plain:"",hairline:"",type:"default",size:"small",icon:"arrow-down",onClick:h=>xe(c,c+1)},null,8,["onClick"]),i(T,{plain:"",hairline:"",type:"default",size:"small",icon:"edit",onClick:h=>je(c)},null,8,["onClick"]),i(T,{plain:"",hairline:"",type:"default",size:"small",icon:"cross",onClick:h=>et(c)},null,8,["onClick"])]),_:2},1024)]),_:2},1024))),128))]),_:1})]),_:1},8,["show"]),i(B,{show:ce.value,"onUpdate:show":n[9]||(n[9]=r=>ce.value=r),round:"",style:{width:"90%",maxHeight:"85%"},onClosed:tt},{default:u(()=>[i(k,null,{default:u(()=>[i($,{title:(t.value==="xray"?"outboundTag: ":"outbound: ")+d.value[I.value].remarks,"title-style":"max-width:100%;height:2rem;font-size:1.2rem",onClick:n[8]||(n[8]=r=>te.value=!0)},null,8,["title"]),(g(!0),O(R,null,Q(qe.value,(r,c)=>(g(),L(p,{type:"textarea",autosize:"",label:c+":",labelWidth:"7em","model-value":r,"onUpdate:modelValue":h=>d.value[I.value][c]=h},null,8,["label","model-value","onUpdate:modelValue"]))),256))]),_:1})]),_:1},8,["show"]),i(B,{show:te.value,"onUpdate:show":n[10]||(n[10]=r=>te.value=r),round:"",style:{width:"90%",maxHeight:"85%"}},{default:u(()=>[i(S,null,{default:u(()=>[(g(!0),O(R,null,Q(Ke.value,r=>(g(),L($,{title:r.remarks,clickable:"",onClick:c=>ke(r)},null,8,["title","onClick"]))),256))]),_:1})]),_:1},8,["show"]),i(B,{show:de.value,"onUpdate:show":n[11]||(n[11]=r=>de.value=r),round:"",style:{width:"90%",maxHeight:"85%"}},{default:u(()=>[i($,{title:s.$t("manage.ruleset-manage"),"title-style":"max-width:100%;"},{"right-icon":u(()=>[i(o,{size:"1.2rem",name:"plus",onClick:at})]),_:1},8,["title"]),i(S,null,{default:u(()=>[(g(!0),O(R,null,Q(N.value,(r,c)=>(g(),L($,{key:c,center:""},{title:u(()=>[q("span",Al,H(r.tag),1)]),value:u(()=>[i(b,null,{default:u(()=>[i(T,{plain:"",hairline:"",type:"default",size:"small",icon:"edit",onClick:h=>De(c)},null,8,["onClick"]),i(T,{plain:"",hairline:"",type:"default",size:"small",icon:"cross",onClick:h=>st(c)},null,8,["onClick"])]),_:2},1024)]),_:2},1024))),128))]),_:1})]),_:1},8,["show"]),i(B,{show:pe.value,"onUpdate:show":n[12]||(n[12]=r=>pe.value=r),round:"",style:{width:"90%",maxHeight:"85%"},onClosed:nt},{default:u(()=>[i(k,null,{default:u(()=>[(g(!0),O(R,null,Q(lt.value,(r,c)=>(g(),L(p,{type:"textarea",autosize:"",label:c+":",labelWidth:"7em","model-value":r,"onUpdate:modelValue":h=>N.value[Z.value][c]=h},null,8,["label","model-value","onUpdate:modelValue"]))),256))]),_:1})]),_:1},8,["show"]),i(B,{show:ge.value,"onUpdate:show":n[13]||(n[13]=r=>ge.value=r),round:"",style:{width:"90%",maxHeight:"85%"}},{default:u(()=>[i($,{title:s.$t("manage.dns-manage"),"title-style":"max-width:100%;"},{"right-icon":u(()=>[i(o,{size:"1.2rem",name:"plus",onClick:rt})]),_:1},8,["title"]),i(S,null,{default:u(()=>[(g(!0),O(R,null,Q(m.value,(r,c)=>(g(),L($,{key:c,center:""},{title:u(()=>[q("span",Sl,H(t.value==="xray"?r.address:r.tag),1)]),value:u(()=>[i(b,null,{default:u(()=>[i(T,{plain:"",hairline:"",type:"default",size:"small",icon:"edit",onClick:h=>Ie(c)},null,8,["onClick"]),i(T,{plain:"",hairline:"",type:"default",size:"small",icon:"cross",onClick:h=>ot(c)},null,8,["onClick"])]),_:2},1024)]),_:2},1024))),128))]),_:1})]),_:1},8,["show"]),i(B,{show:ve.value,"onUpdate:show":n[14]||(n[14]=r=>ve.value=r),round:"",style:{width:"90%",maxHeight:"85%"},onClosed:ut},{default:u(()=>[i(k,null,{default:u(()=>[(g(!0),O(R,null,Q(it.value,(r,c)=>(g(),L(p,{type:"textarea",autosize:"",label:c+":",labelWidth:"7em","model-value":r,"onUpdate:modelValue":h=>m.value[Y.value][c]=h},null,8,["label","model-value","onUpdate:modelValue"]))),256))]),_:1})]),_:1},8,["show"]),i(B,{show:me.value,"onUpdate:show":n[15]||(n[15]=r=>me.value=r),round:"",style:{width:"90%",maxHeight:"85%"}},{default:u(()=>[i($,{title:s.$t("manage.dnsrule-manage"),"title-style":"max-width:100%;"},{"right-icon":u(()=>[i(o,{size:"1.2rem",name:"plus",onClick:dt})]),_:1},8,["title"]),i(S,null,{default:u(()=>[(g(!0),O(R,null,Q(z.value,(r,c)=>(g(),L($,{key:c,center:""},{title:u(()=>[q("span",Ll,H(r.server),1)]),value:u(()=>[i(b,null,{default:u(()=>[i(T,{plain:"",hairline:"",type:"default",size:"small",icon:"arrow-up",onClick:h=>Te(c,c-1)},null,8,["onClick"]),i(T,{plain:"",hairline:"",type:"default",size:"small",icon:"arrow-down",onClick:h=>Te(c,c+1)},null,8,["onClick"]),i(T,{plain:"",hairline:"",type:"default",size:"small",icon:"edit",onClick:h=>Ce(c)},null,8,["onClick"]),i(T,{plain:"",hairline:"",type:"default",size:"small",icon:"cross",onClick:h=>pt(c)},null,8,["onClick"])]),_:2},1024)]),_:2},1024))),128))]),_:1})]),_:1},8,["show"]),i(B,{show:Me.value,"onUpdate:show":n[16]||(n[16]=r=>Me.value=r),round:"",style:{width:"90%",maxHeight:"85%"},onClosed:ft},{default:u(()=>[i(k,null,{default:u(()=>[(g(!0),O(R,null,Q(ct.value,(r,c)=>(g(),L(p,{type:"textarea",autosize:"",label:c+":",labelWidth:"7em","model-value":r,"onUpdate:modelValue":h=>z.value[V.value][c]=h},null,8,["label","model-value","onUpdate:modelValue"]))),256))]),_:1})]),_:1},8,["show"])])):ne("",!0)],64)}}};export{Ql as default};