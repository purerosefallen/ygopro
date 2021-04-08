--高速决斗技能-被托付的卡
Duel.LoadScript("speed_duel_common.lua")
function c100730027.initial_effect(c)
	aux.SpeedDuelBeforeDraw(c,c100730027.skill)
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730027.skill(e,tp)
   tp = e:GetLabelObject():GetOwner()
   local c=Duel.CreateToken(tp,24874630)
   Duel.SendtoDeck(c,tp,0,REASON_RULE)
   e:Reset()
end