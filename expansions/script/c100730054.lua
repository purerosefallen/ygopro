--高速决斗技能-来自虚无的复仇
Duel.LoadScript("speed_duel_common.lua")
function c100730054.initial_effect(c)
	aux.SpeedDuelMoveCardToDeckCommon(72896720,c)
	aux.SpeedDuelMoveCardToDeckCommon(38904695,c)
	aux.SpeedDuelMoveCardToDeckCommon(81020646,c)
	aux.SpeedDuelBeforeDraw(c,c100730054.skill)
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730054.skill(e,tp,eg,ep,ev,re,r,rp)
	tp=e:GetLabelObject():GetOwner()
	e:Reset()
	if Duel.IsExistingMatchingCard(Card.IsAttribute,tp,LOCATION_DECK,0,1,nil,0x5f) then
		Duel.Hint(HINT_MESSAGE,tp,aux.Stringid(100730054,0))
	else
		aux.SpeedDuelSendToDeckWithExile(tp,g)
		local c=Duel.CreateToken(tp,85475641)
		Duel.SendtoGrave(c,REASON_RULE)
	end
end
