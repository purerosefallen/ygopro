--高速决斗技能-被托付的卡
Duel.LoadScript("speed_duel_common.lua")
function c100730003.initial_effect(c)
	aux.SpeedDuelBeforeDraw(c,c100730003.skill)
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730003.skill(e,tp)
   tp = e:GetLabelObject():GetOwner()
   local c=Duel.CreateToken(tp,29228529)
   Duel.SendtoDeck(c,tp,0,REASON_RULE)
   local d=Duel.CreateToken(tp,24874630)
   Duel.SendtoDeck(d,tp,0,REASON_RULE)
   local d1=Duel.CreateToken(tp,55144522)
   Duel.SendtoDeck(d1,tp,0,REASON_RULE)
   e:Reset()
end