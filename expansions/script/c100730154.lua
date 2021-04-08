--高速决斗技能-神官的咏唱
Duel.LoadScript("speed_duel_common.lua")
function c100730154.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730154.skill,c100730154.con,aux.Stringid(100730154,0))
	local e3=Effect.GlobalEffect()
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_PREDRAW)
	e3:SetOperation(c100730154.operation)
	e3:SetLabel(10000090)
	e3:SetLabelObject(c)
	Duel.RegisterEffect(e3,0)
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730154.operation(e,tp,eg,ep,ev,re,r,rp)
	local id=e:GetLabel()
	tp = e:GetLabelObject():GetOwner()
	local c=Duel.CreateToken(tp,id)
	Duel.SendtoGrave(c,REASON_RULE)
	e:Reset()
end
function c100730154.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(Card.IsAbleToGrave,tp,LOCATION_HAND,0,1,nil)
end
function c100730154.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730154)
	local g1=Duel.SelectMatchingCard(tp,Card.IsAbleToGrave,tp,LOCATION_HAND,0,1,6,nil)
	if not g1 then return end
	Duel.SendtoGrave(g1,nil,REASON_RULE)
	local g=Duel.SelectMatchingCard(tp,Card.IsCode,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil,10000010)
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