--高速决斗技能-这不是怪兽！是神！
Duel.LoadScript("speed_duel_common.lua")
function c100730078.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730078.skill,c100730078.con,aux.Stringid(100730078,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730078.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(Card.IsAbleToGrave,tp,LOCATION_HAND,0,1,nil)

end
function c100730078.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(Card.IsAbleToGrave,tp,LOCATION_HAND,0,1,nil)
end
function c100730078.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730078)
	local g1=Duel.SelectMatchingCard(tp,Card.IsAbleToGrave,tp,LOCATION_HAND,0,1,6,nil)
	if not g1 then return end
	Duel.SendtoGrave(g1,nil,REASON_RULE)
	local g=Duel.SelectMatchingCard(tp,Card.IsCode,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil,10000000)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
		if g:GetFirst():IsLocation(LOCATION_HAND) then
			if Duel.IsPlayerCanSummon(tp) and Duel.IsPlayerCanAdditionalSummon(tp) and Duel.GetFlagEffect(tp,78665705)==0 then
				local e1=Effect.CreateEffect(e:GetHandler())
				e1:SetDescription(aux.Stringid(100730154,0))
				e1:SetType(EFFECT_TYPE_FIELD)
				e1:SetTargetRange(LOCATION_HAND,0)
				e1:SetCode(EFFECT_EXTRA_SUMMON_COUNT)
				e1:SetValue(0x1)
				e1:SetReset(RESET_PHASE+PHASE_END)
				Duel.RegisterEffect(e1,tp)
				local e2=e1:Clone()
				e2:SetCode(EFFECT_EXTRA_SET_COUNT)
				Duel.RegisterEffect(e2,tp)
				Duel.RegisterFlagEffect(tp,78665705,RESET_PHASE+PHASE_END,0,1)
			end
		end
	end
end