--高速决斗技能-寄生虫感染
Duel.LoadScript("speed_duel_common.lua")
function c100730027.initial_effect(c)
	aux.SpeedDuelBeforeDraw(c,c100730027.skill)
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730027.filter(c,g)
	if not c:IsRace(RACE_INSECT) then return false end
	local tc=g:GetFirst()
	while tc do
		if c:GetOriginalCode()==tc:GetOriginalCode() then
			return false
		end
		tc=g:GetNext()
	end
	g:AddCard(c)
	return true
end
function c100730027.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	local g=Group.CreateGroup()
	if not Duel.IsExistingMatchingCard(c100730027.filter,tp,LOCATION_DECK+LOCATION_HAND,0,4,nil,g) then
		Duel.Hint(HINT_MESSAGE,tp,aux.Stringid(100730027,0))
		e:Reset()
		return
	end
	tp=e:GetLabelObject():GetOwner()
	local count=1
	if Duel.TossCoin(tp,1)==1 then
		count=2
	end
	while count>0 do
		local parasite=Duel.CreateToken(tp,27911549)
		Duel.DisableShuffleCheck()
		Duel.SendtoDeck(parasite,1-tp,2,REASON_RULE)
		Card.ReverseInDeck(parasite)
		local e1=Effect.CreateEffect(c)
		e1:SetDescription(aux.Stringid(27911549,1))
		e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
		e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
		e1:SetCode(EVENT_DRAW)
		e1:SetTarget(c100730027.sptg)
		e1:SetOperation(c100730027.spop)
		e1:SetReset(RESET_EVENT+0x1de0000)
		c:RegisterEffect(e1)
		count=count-1
	end
	Duel.ShuffleDeck(1-tp)
	e:Reset()
end
function c100730027.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsRelateToEffect(e) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c100730027.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		if Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP_DEFENSE)>0 then
			Duel.Damage(tp,1000,REASON_EFFECT)
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_FIELD)
			e1:SetCode(EFFECT_CHANGE_RACE)
			e1:SetRange(LOCATION_MZONE)
			e1:SetTargetRange(LOCATION_MZONE,0)
			e1:SetValue(RACE_INSECT)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD)
			c:RegisterEffect(e1)
		end
	end
end