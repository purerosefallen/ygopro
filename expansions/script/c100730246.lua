--高速决斗技能-鲨鱼领域
Duel.LoadScript("speed_duel_common.lua")
function c100730246.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730246.skill,c100730246.con)
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730246.con(e,tp)
	local tp=e:GetHandlerPlayer()
	local g=Duel.GetMatchingGroup(Card.IsType,tp,LOCATION_EXTRA,0,nil,TYPE_MONSTER)
	if g:GetClassCount(Card.GetOriginalAttribute)>1 or g:GetCount()==0 then return false end
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(c100730246.filter,tp,LOCATION_MZONE,0,1,nil)
		and Duel.IsExistingMatchingCard(Card.IsAttribute,tp,LOCATION_EXTRA,0,1,nil,ATTRIBUTE_WATER)
end
function c100730246.skill(e,tp,c)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730246)
	local g=Duel.GetMatchingGroup(c100730246.filter,tp,LOCATION_MZONE,0,1,nil)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(tc)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_CHANGE_LEVEL)
		e1:SetValue(4)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
end
function c100730246.filter(c)
	return c:IsType(TYPE_MONSTER) and c:IsFaceup() and c:IsAttribute(ATTRIBUTE_WATER)
end