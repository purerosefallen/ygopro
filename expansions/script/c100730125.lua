--高速决斗技能-光之化身：银河眼
Duel.LoadScript("speed_duel_common.lua")
function c100730125.initial_effect(c)
	aux.SpeedDuelMoveCardToDeckCommon(93717133,c)
	aux.SpeedDuelAtMainPhase(c,c100730125.skill,c100730125.con,aux.Stringid(100730125,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730125.Is2000(c)
	return c:IsType(TYPE_MONSTER) and c:IsFaceup() and c:GetAttack()>=2000
end

function c100730125.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(c100730125.Is2000,tp,LOCATION_MZONE,0,2,nil)
end
function c100730125.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730125)
	local g=Duel.GetMatchingGroup(c100730125.Is2000,tp,LOCATION_MZONE,0,nil)
	if g:GetCount()==0 then return end
	local g=Duel.SelectMatchingCard(tp,Card.IsCode,tp,LOCATION_DECK+LOCATION_GRAVE+LOCATION_REMOVED,0,1,1,nil,93717133)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_RULE)
		Duel.ConfirmCards(1-tp,g)
	end
end