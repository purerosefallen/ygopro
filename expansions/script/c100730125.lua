--高速决斗技能-光之化身：银河眼
Duel.LoadScript("speed_duel_common.lua")
function c100730125.initial_effect(c)
	aux.SpeedDuelMoveCardToDeckCommon(93717133,c)
	aux.SpeedDuelAtMainPhase(c,c100730125.skill,c100730125.con,aux.Stringid(100730125,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730125.Is8800(c)
	return c:IsType(TYPE_MONSTER) and c:IsFaceup() and c:GetTextAttack()>2000
end

function c100730125.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(c100730125.Is8800,tp,LOCATION_MZONE,0,1,nil)
		and Duel.GetMZoneCount(tp)>-1
end
function c100730125.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730125)
	local g=Duel.GetMatchingGroup(c100730125.Is8800,tp,LOCATION_MZONE,0,nil)
	if g:GetCount()==0 then return end
	local c=Duel.CreateToken(tp,93717133)
	Duel.SendtoHand(c,nil,REASON_RULE)
end