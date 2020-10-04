--高速决斗技能-空手组合技100
Duel.LoadScript("speed_duel_common.lua")
function c100730075.initial_effect(c)
	aux.SpeedDuelMoveCardToFieldCommon(95453143,c)
	aux.SpeedDuelBeforeDraw(c,c100730075.skill)
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730075.skill(e,tp,eg,ep,ev,re,r,rp)
	tp=e:GetLabelObject():GetOwner()
	local g=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
	aux.SpeedDuelSendToDeckWithExile(tp,g)
end