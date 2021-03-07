--高速决斗技能-空手组合技永火
Duel.LoadScript("speed_duel_common.lua")
function c100730129.initial_effect(c)
	aux.SpeedDuelMoveCardToDeckCommon(81020646,c)
	aux.SpeedDuelMoveCardToDeckCommon(38904695,c)
	aux.SpeedDuelMoveCardToDeckCommon(72896720,c)
	aux.SpeedDuelMoveCardToFieldCommon(63665606,c)
	aux.SpeedDuelMoveCardToFieldCommon(66957584,c)
	aux.SpeedDuelBeforeDraw(c,c100730129.skill)
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730129.skill(e,tp,eg,ep,ev,re,r,rp)
	tp=e:GetLabelObject():GetOwner()
	local g=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
	aux.SpeedDuelSendToDeckWithExile(tp,g)
end