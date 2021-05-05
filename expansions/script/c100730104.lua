--高速决斗技能-攻击力：8800P
Duel.LoadScript("speed_duel_common.lua")
function c100730104.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730104.skill,c100730104.con,aux.Stringid(100730104,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730104.Is8800(c)
	return c:IsLevel(4) and c:IsFaceup() and c:GetAttack()==c:GetDefense()
end

function c100730104.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(c100730104.Is8800,tp,LOCATION_MZONE,0,1,nil)
end
function c100730104.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730104)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectMatchingCard(tp,c100730104.Is8800,tp,LOCATION_MZONE,0,1,1,nil)
	local tc=g:GetFirst()
	local e1=Effect.CreateEffect(tc)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_BASE_ATTACK)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetValue(8800)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
	tc:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetTargetRange(1,0)
	e2:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e2,1-tp)
end