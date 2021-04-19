--高速决斗技能-时间推移
Duel.LoadScript("speed_duel_common.lua")
function c100730239.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730239.skill,c100730239.con,aux.Stringid(100730239,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730239.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(c100730239.filter,tp,LOCATION_MZONE,0,1,nil)
end
function c100730239.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x31)
end
function c100730239.skill(e,tp,c)
	tp=e:GetLabelObject():GetOwner()
	local g=Duel.SelectMatchingCard(tp,c100730239.filter,tp,LOCATION_MZONE,0,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		Duel.Hint(HINT_CARD,1-tp,100730239)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_LEVEL)
		e1:SetValue(3)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		local g2=Duel.SelectMatchingCard(tp,Card.IsCode,tp,LOCATION_GRAVE+LOCATION_DECK,0,0,3,nil,94068856)
		Duel.SendtoHand(g2,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g2)
		if g2:GetCount()<=1 then return end
		e:Reset()
	end
end