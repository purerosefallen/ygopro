--高速决斗技能-命运封闭
Duel.LoadScript("speed_duel_common.lua")
function c100730243.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730243.skill,c100730243.con,aux.Stringid(100730243,0))
	aux.SpeedDuelBeforeDraw(c,c100730243.skill2)
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730243.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(c100730243.filter,tp,LOCATION_MZONE,0,1,nil)
end
function c100730243.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x31)
end
function c100730243.skill(e,tp,c)
	tp=e:GetLabelObject():GetOwner()
	local g=Duel.SelectMatchingCard(tp,c100730243.filter,tp,LOCATION_MZONE,0,1,1,nil)
	local count= Duel.GetTurnCount()
	local tc=g:GetFirst()
	if tc then
		Duel.Hint(HINT_CARD,1-tp,100730243)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_LEVEL)
		e1:SetValue(count)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		local g2=Duel.SelectMatchingCard(tp,Card.IsCode,tp,LOCATION_DECK,0,0,1,nil,94662235)
		if g2:GetCount()==0 then return end
		Duel.SendtoHand(g2,tp,REASON_RULE)
	end
end
function c100730243.skill2(e,tp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730240)
	local c=Duel.CreateToken(tp,49826746)
	Duel.SendtoGrave(c,REASON_RULE)
	e:Reset()
end