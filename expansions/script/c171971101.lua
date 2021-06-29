--魔偶甜点菜单管理
function c171971101.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(60470713,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,171971101)
	e1:SetCost(c171971101.cost)
	e1:SetTarget(c171971101.target)
	e1:SetOperation(c171971101.activate)
	c:RegisterEffect(e1)
	--todeck
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(4779823,1))
	e2:SetCategory(CATEGORY_TODECK)
	e2:SetType(EFFECT_TYPE_ACTIVATE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetCountLimit(1,17197102)
	e2:SetTarget(c171971101.thtg)
	e2:SetOperation(c171971101.thop)
	c:RegisterEffect(e2)
end
function c171971101.rfilter(c,tp)
	return c:IsSetCard(0x71) and c:IsType(TYPE_MONSTER) and (c:IsControler(tp) or c:IsFaceup())
end
function c171971101.spfilter(c,e,tp)
	return c:IsSetCard(0x71) and c:IsType(TYPE_MONSTER) and (c:IsAbleToHand() or chk and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENSE))
end
function c171971101.fselect(g,tp)
	return Duel.GetMZoneCount(tp,g)>=g:GetCount()
end
function c171971101.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(100)
	local rg=Duel.GetReleaseGroup(tp):Filter(c171971101.rfilter,nil,tp)
	local sg=Duel.GetMatchingGroup(c171971101.spfilter,tp,LOCATION_DECK,0,nil,e,tp)
	local maxc=math.min(1,rg:GetCount(),(Duel.GetMZoneCount(tp,rg)),sg:GetClassCount(Card.GetCode))
	if chk==0 then return maxc>0 and rg:CheckSubGroup(c171971101.fselect,1,maxc,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=rg:SelectSubGroup(tp,c171971101.fselect,false,1,maxc,tp)
	e:SetLabel(g:GetCount())
	Duel.SendtoDeck(g,nil,2,REASON_EFFECT)
end
function c171971101.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetLabel()==100 end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,e:GetLabel(),tp,LOCATION_DECK)
end
function c171971101.activate(e,tp,eg,ep,ev,re,r,rp)
	local b=Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsExistingMatchingCard(c171971101.mfilter,tp,LOCATION_MZONE,0,1,nil)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	local ct=e:GetLabel()
	if ft<ct or ft<=0 then return end
	local g=Duel.GetMatchingGroup(c171971101.spfilter,tp,LOCATION_DECK,0,nil,e,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local sg=g:SelectSubGroup(tp,aux.dncheck,false,ct,ct)
	if sg then
		if b and (not Duel.IsPlayerAffectedByEffect(tp,59822133) or ft==1) and Duel.SelectOption(tp,1190,1152)==1 then
			Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
		else
			Duel.SendtoHand(sg,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,sg)
		end
	end
	if e:GetHandler():IsRelateToEffect(e) then
		e:GetHandler():CancelToGrave()
		Duel.SendtoDeck(e:GetHandler(),nil,1,REASON_EFFECT)
	end
end
function c171971101.mfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x71) and c:IsRace(RACE_FAIRY)
end
function c171971101.thfilter(c)
	return c:IsSetCard(0x71) and (c:IsLocation(LOCATION_GRAVE) or c:IsFaceup()) and c:IsAbleToDeck()
end
function c171971101.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE+LOCATION_REMOVED) and chkc:IsControler(tp) and c171971101.thfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c171971101.thfilter,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local sg=Duel.SelectTarget(tp,c171971101.thfilter,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,1,36,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,sg,sg:GetCount(),0,0)
end
function c171971101.thop(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if not tg then return end
	Duel.SendtoDeck(tg,nil,0,REASON_EFFECT)
	local g=Duel.GetOperatedGroup()
	if g:IsExists(Card.IsLocation,1,nil,LOCATION_DECK) then Duel.ShuffleDeck(tp) end
	local ct=g:FilterCount(Card.IsLocation,nil,LOCATION_DECK+LOCATION_EXTRA)
	Duel.Recover(tp,ct*300,REASON_EFFECT)
	if e:GetHandler():IsRelateToEffect(e) then
		e:GetHandler():CancelToGrave()
		Duel.SendtoDeck(e:GetHandler(),nil,1,REASON_EFFECT)
	end
end